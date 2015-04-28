class ItemsController < ApplicationController

  def new
    @item = Item.new
  end

  def create_folder
    @subject = Subject.find(cookies[:current_subject])
    @subject.items.create(folder_params.merge(subject: @subject))
    redirect_to subject_path(cookies[:current_subject]), notice: 'The folder has been successfully created.'
  end

  private

  def folder_params
    params.require(:item).permit(:name, :parent_id)
  end

end
