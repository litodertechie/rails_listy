class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def profile
    @my_lists = current_user.lists
  end
end
