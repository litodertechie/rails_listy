class ProfilesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index, :autocomplete]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json, :js
  impressionist :actions=>[:show]

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
      misspellings: false
    }).map(&:username)
  end


  def show
    impressionist(@user)
    @followers = @user.followers
    @following = @user.all_following
  end



  private
  def set_user
    @user = User.friendly.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :photo, :photo_cache, :provider, :uid, :facebook_picture_url, :token, :token_expiry)
  end
end
