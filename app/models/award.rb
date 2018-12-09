require 'aws-sdk'
class Award < ApplicationRecord
  belongs_to :award_category
  belongs_to :giver, class_name: "User"
  belongs_to :given, class_name: "User"
  has_and_belongs_to_many :award_tags

  validates :giver_id, presence: true
  validates :given_id, presence: true
  validates :contents, presence: true
  validate :ids_differ?

  def make_award_img(giver_id, given_id)
    set_url
    award_contents = self.contents
    award_img = Magick::ImageList.new("#{Rails.root}/app/assets/images/award.png")
    resized_award_img = award_img.resize(300, 300)
    font = "#{Rails.root}/app/assets/fonts/GenJyuuGothic-Heavy.ttf"
    draw = Magick::Draw.new
    draw.annotate(resized_award_img, 100, 100, 100, 100, "#{Date.today}#{award_contents}したで賞") do
      self.font = font
    end
    resized_award_img.write(@upload_to_thisURL)
  end

  def create_with_upload!(giver_id, given_id)
    Award.transaction do
      self.save!
      upload_aws(giver_id, given_id)
      send_email(giver_id, given_id)
    end
  end

  def ids_differ?
    if giver_id == given_id
      errors.add(I18n.t("view.award"), "は自分には送れません")
    end
  end

  private

    def send_email(giver_id, given_id)
      MailWorker.perform_async(giver_id, given_id)
    end

    def set_url
      @upload_to_thisURL = "#{Rails.root}/app/assets/images/fromUser#{giver_id}_toUser#{given_id}award_img.png"
    end

    def upload_aws(giver_id, given_id)
      set_url
      Aws.config.update({
      credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])})
      s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'])
      bucket = s3.bucket('prize-object')
      object = bucket.object("#{self.id}-award.png")
      object.upload_file(@upload_to_thisURL)
    end
end
