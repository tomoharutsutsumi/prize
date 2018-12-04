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

  def aws
    Aws.config.update({
    credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'])})
    s3 = Aws::S3::Resource.new(region: 'ap-northeast-1')
    bucket = s3.bucket('prize-object')
    object = bucket.object('award.png')
    object.upload_file("annotated_award_img.png")
  end

  def make_award_img
    award_contents = self.contents
    award_img = Magick::ImageList.new("#{Rails.root}/app/assets/images/award.png")
    resized_award_img = award_img.resize(300, 300)
    font = "#{Rails.root}/app/assets/fonts/GenJyuuGothic-Heavy.ttf"
    draw = Magick::Draw.new
    draw.annotate(resized_award_img, 100, 100, 100, 100, "#{Date.today}#{award_contents}したで賞") do
      self.font = font
    end
    resized_award_img.write("#{Rails.root}/app/assets/images/annotated_award_img.png")
    aws
  end

  def ids_differ?
    if giver_id == given_id
      errors.add(I18n.t("view.award"), "は自分には送れません")
    end
  end
end
