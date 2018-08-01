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

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :photo, :photo_cache)
  end
end
