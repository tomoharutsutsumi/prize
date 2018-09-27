require 'aws-sdk'
class Award < ApplicationRecord
  belongs_to :giver, class_name: "User"
  belongs_to :given, class_name: "User"

  validates :giver_id, presence: true
  validates :given_id, presence: true
  validates :contents, presence: true

  def upload_aws
    Aws.config.update({
    credentials: Aws::Credentials.new(ENV['ACCESS_KEY_ID'], ENV['SECRET_ACCESS_KEY'])})
    s3 = Aws::S3::Resource.new(region: 'ap-northeast-1')
    bucket = s3.bucket('prize-object')
   # binding.pry
    count_numbers
    object = bucket.object("#{@number}-award.png")
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
  end

  def count_numbers
    if Award.exists?
      @number = Award.last.id
    else
      @number = 1
    end
  end


end
