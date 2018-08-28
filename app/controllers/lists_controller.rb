class ListsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  before_action :set_list, only: [:show, :edit, :update, :destroy, :vote]
  respond_to :js, :json, :html
  def show
    @number_likes = @list.get_upvotes.size
    @people_who_liked = @list.votes_for.up.by_type(User).voters
  end

  def index
  end

  def new
    @list = List.new items: [Item.new]
  end


  def edit
  end

  def create
    @list = List.new(list_params)
    @list.user = current_user
    if @list.save
      @list.create_activity :create, owner: current_user
      redirect_to list_path(@list), notice: 'List was successfully created'
    else
      render :new
    end
  end

  def update
    if @list.update(list_params)
      @list.create_activity :update, owner: current_user
      redirect_to profile_path(current_user), notice: 'List was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @list.destroy
    redirect_to profile_path(current_user), notice: 'List was successfully deleted.'
  end

  def vote
    if !current_user.liked? @list
      @list.liked_by current_user
    elsif current_user.liked? @list
      @list.unliked_by current_user
    end
  end


  private

  def set_list
    @list = List.find(params[:id])
  end


  def list_params
    params.require(:list).permit(:name, items_attributes: Item.attribute_names.map(&:to_sym).push(:_destroy))
  end
end
