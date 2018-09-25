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
  devise :omniauthable, omniauth_providers: [:facebook]
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

  def set_avatar
    if self.facebook_picture_url?
      self.remote_photo_url = facebook_picture_url
    elsif self.photo.file.nil?
      self.remote_photo_url = "http://res.cloudinary.com/dgccrihdr/image/upload/v1534339332/default-avatar.png"
    else
      self.remote_photo_url
    end
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

  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.

    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20] # Fake password for validation
      user.username = [user.first_name, user.last_name].join.downcase
      user.set_avatar
      user.save
    end

    return user
  end


  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end
end
