class ItemsController < ApplicationController

  respond_to :html, :js

  def new
    @item = Item.new
  end

  def create_folder
    @subject = Subject.find(cookies[:current_subject])
    @item = @subject.items.create(folder_params.merge(subject: @subject))
    redirect_to subject_path(id: @subject.id, parent: @item.parent_id), notice: 'The folder has been successfully created.'
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @items = Item.all
    @item = Item.find(params[:id])
    @item.update_attributes(folder_params)
  end

  def delete
    @item = Item.find(params[:item_id])
  end

  def destroy
    @items = Item.all
    @item = Item.find(params[:id])
    @item.destroy
  end

  private

  def folder_params
    params.require(:item).permit(:name, :parent_id)
  end

end
