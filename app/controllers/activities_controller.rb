class ActivitiesController < ApplicationController
  def index
    # @users = User.where(user.lists.count > 2 )
    @activities = ::PublicActivity::Activity.order("created_at desc").where(owner_id: current_user.all_following.pluck(:id), owner_type: "User")
  end
end
