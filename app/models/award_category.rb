class AwardCategory < ApplicationRecord
  has_many :awards
  validates :level, presence: true
end
