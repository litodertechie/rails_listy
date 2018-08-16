class User < ApplicationRecord
  include Impressionist::IsImpressionable
  is_impressionable
  extend FriendlyId
  friendly_id :username, use: :slugged
  mount_uploader :photo, PhotoUploader
  searchkick word_start: [:first_name, :last_name, :username]
  acts_as_follower
  acts_as_followable
  acts_as_voter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :lists, dependent: :destroy
  after_create :send_welcome_email

  def search_data
    {
      username: username,
      first_name: first_name,
      last_name: last_name
    }
  end

  def should_generate_new_friendly_id?
    new_record?
  end


  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end
end
