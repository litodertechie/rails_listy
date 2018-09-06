class ActivitiesController < ApplicationController
  def index
    following_ids = current_user.all_following.pluck(:id)
    @users = User.where.not(id: following_ids).where.not(id: current_user.id).joins(:lists).group('users.id').having('count(user_id) > 1')
    @users = @users[0..2]
    @activities = ::PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.all_following.pluck(:id), owner_type: "User")
  end
end
