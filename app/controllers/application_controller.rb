class ApplicationController < ActionController::Base
  include ::PublicActivity::StoreController
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(user)
  activities_path
  end

  def current_user
    super || OpenStruct.new(username: "guestuser", first_name: "guest", last_name:"user", email: "guestuser@example.com")
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :username, :last_name, :photo, :photo_cache])
  end
end



