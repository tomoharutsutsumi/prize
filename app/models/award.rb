require 'aws-sdk'
class Award < ApplicationRecord
  belongs_to :giver, class_name: "User"
  belongs_to :given, class_name: "User"

  validates :giver_id, presence: true
  validates :given_id, presence: true
  validates :contents, presence: true

  def upload_aws(giver_id, given_id)
    s3 = Aws::S3::Resource.new(region: 'ap-northeast-1')
    bucket = s3.bucket('prize-object')
    object = bucket.object("#{self.id}-award.png")
    object.upload_file("#{Rails.root}/app/assets/images/fromUser#{giver_id}_toUser#{given_id}award_img.png")
  end

  def make_award_img(giver_id, given_id)
    award_contents = self.contents
    award_img = Magick::ImageList.new("#{Rails.root}/app/assets/images/award.png")
    resized_award_img = award_img.resize(300, 300)
    font = "#{Rails.root}/app/assets/fonts/GenJyuuGothic-Heavy.ttf"
    draw = Magick::Draw.new
    draw.annotate(resized_award_img, 100, 100, 100, 100, "#{Date.today}#{award_contents}したで賞") do
      self.font = font
    end
    resized_award_img.write("#{Rails.root}/app/assets/images/fromUser#{giver_id}_toUser#{given_id}award_img.png")
  end

  def create_with_upload!(giver_id, given_id)
    Award.transaction do
      self.save!
      self.upload_aws(giver_id, given_id)
    end
  end

end
