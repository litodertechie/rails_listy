class Follow < ActiveRecord::Base

  extend ActsAsFollower::FollowerLib
  extend ActsAsFollower::FollowScopes

  # NOTE: Follows belong to the "followable" and "follower" interface
  belongs_to :followable, polymorphic: true
  belongs_to :follower,   polymorphic: true
  # belongs_to :follower, class_name: 'User', -> { where(follows: { followable_type: 'User' }) }, foreign_key: 'followable_id'


  def block!
    self.update_attribute(:blocked, true)
  end

end
