class ListsController < ApplicationController
  before_action :set_todo_list, only: [:show, :edit, :update, :destroy]

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
      redirect_to edit_list_path(@list), notice: 'List was successfully created'
    else
      render :new
    end
  end

  def update
    if @list.update(list_params)
      redirect_to edit_list_path(@list), notice: 'List was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @list.destroy
  end


  private

  def set_todo_list
    @list = List.find(params[:id])
  end


  def list_params
    params.require(:list).permit(:name, items_attributes: Item.attribute_names.map(&:to_sym).push(:_destroy))
  end  
end
