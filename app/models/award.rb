class Award < ApplicationRecord
  belongs_to :giver, class_name: "User"
  belongs_to :given, class_name: "User"

  validates :giver_id, presence: true
  validates :given_id, presence: true
  validates :contents, presence: true

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

  def give(giver_user, given_user)
    create(giver_id: giver_user.id, given_id: given_user.id)
  end



end
