class Relationship < ApplicationRecord
  belongs_to :giver, class_name: "User"
  belongs_to :given, class_name: "User"
  validates :giver_id, presence: true
  validates :given_id, presence: true
end
