class User < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  searchkick
  acts_as_follower
  acts_as_followable
  acts_as_voter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :lists, dependent: :destroy

  def search_data
    {
      username: username,
      first_name: first_name,
      last_name: last_name
    }
  end
end
