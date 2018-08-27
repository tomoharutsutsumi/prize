class Award < ApplicationRecord
  belongs_to :user
  validates :contents, presence: true
end
