class ProfilesController < ApplicationController
  def show
    raise
    @user = current_user
  end

  def profile
    @my_lists = current_user.lists
  end
end
