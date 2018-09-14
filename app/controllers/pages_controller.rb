class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :show]

  def show
    render template: "pages/#{params[:page]}"
  end

  def home
  end
end
