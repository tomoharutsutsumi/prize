class User < ApplicationRecord
  has_many :awards, class_name: "Award", foreign_key: "giver_id"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         #, :omniauthable, omniauth_providers: [:twitter]


  has_many :giving_awards, class_name: "Award",
  foreign_key: "giver_id",
  dependent: :destroy
  has_many :given_awards, class_name: "Award",
  foreign_key: "given_id",
  dependent: :destroy


  def give(given_user)
    giving_awards.create(given_id: given_user.id)
  end

  #自分が賞を送った人一覧


  #自分に賞を送ってくれた人一覧



end
