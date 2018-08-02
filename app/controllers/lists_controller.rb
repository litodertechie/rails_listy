class ListsController < ApplicationController
  before_action :set_todo_list, only: [:show, :edit, :update, :destroy]

  def show
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
      redirect_to profile_path(current_user), notice: 'List was successfully created'
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


  private

  def set_todo_list
    @list = List.find(params[:id])
  end


  def list_params
    params.require(:list).permit(:name, items_attributes: Item.attribute_names.map(&:to_sym).push(:_destroy))
  end
end
