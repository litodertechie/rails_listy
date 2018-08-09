class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    search = params[:term].present? ? params[:term] : nil
    @users = if search
    User.search(search)
    else
      User.all
    end
  end

  def autocomplete
    render json: User.search(params[:query], {
      fields: ["first_name", "last_name", "username"],
      match: :word_start,
      limit: 10,
      load: false,
      misspellings: {below: 5}
    }).map(&:username)
  end

  def show
    @user = User.find(params[:id])
  end

  def profile
    @my_lists = current_user.lists
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :photo, :photo_cache)
  end
end
