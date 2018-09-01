class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         #, :omniauthable, omniauth_providers: [:twitter]


  has_many :active_relationships, class_name: "User",
  foreign_key: "giver_id",
  dependent: :destroy
  has_many :passive_relationships, class_name: "User",
  foreign_key: "given_id",
  dependent: :destroy
  has_many :giving, through: :active_relationships, source: :given
  has_many :givers, through: :passive_relationships, source: :giver

  def give(given_user)
    active_relationships.create(given_id: given_user.id)
  end


end
