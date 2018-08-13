class UsersController < ApplicationController
  before_action :set_user
  def follow
    current_user.follow(@user)
    redirect_to profile_path(@user)
  end

  def unfollow
    current_user.stop_following(@user)
    redirect_to profile_path(@user)
  end

  def follow_suggestions
    following_ids = current_user.all_following.pluck(:id)
    @users = User.where.not(id: following_ids).where.not(id: current_user.id).joins(:lists).group('users.id').having('count(user_id) > 1')
  end

  private
  def set_user
    @user = User.friendly.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :photo, :photo_cache)
  end
end

