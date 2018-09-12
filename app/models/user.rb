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
  has_many :notifications, foreign_key: :recipient_id, dependent: :destroy
  has_many :sent_notifications, class_name: "Notification", foreign_key: :actor_id, dependent: :destroy
  after_create :send_welcome_email
  after_create :identify_user
  after_update :track_user_update
  validates_uniqueness_of :username
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

  def notification_to_s
    "started following you"
  end

  def identify_user
    $tracker.people.set(
      id, {    # we already have user object, setting its ID using the object
    '$first_name'       => first_name,
    '$last_name'        => last_name,
    '$email'            => email,
    '$username'         => username
    })
    $tracker.track( id , "Created Account")
  end

  def track_user_update
    $tracker.track( id , "Updated Profile")
  end

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end
end
