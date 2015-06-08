class FoldersController < ApplicationController

  respond_to :html, :js

  def new
    @folder = Folder.new
  end

  def create
    @subject = Subject.find(cookies[:current_subject])
    @folder = @subject.folders.create(folder_params.merge(subject: @subject))
    redirect_to subject_path(id: @subject.id, parent: @folder.parent_id), notice: 'The folder has been successfully created.'
  end

  def edit
    @folder = Folder.find(params[:id])
  end

  def update
    @folders = Folder.all
    @folder = Folder.find(params[:id])
    @folder.update_attributes(folder_params)
  end

  def delete
    @folder = Folder.find(params[:folder_id])
  end

  def destroy
    @folders = Folder.all
    @folder = Folder.find(params[:id])
    @folder.destroy
  end

  def favourite
    @folder = Folder.find(params[:folder_id])
    if @folder.favourite? current_user
      # FavFolder.where(folder_id: @folder.id, user_id: current_user.id).first.destroy
      current_user.fav_folders.find_by_folder_id(@folder.id).destroy
    else
      @fav_folder = current_user.fav_folders.create(folder_id: @folder.id)
    end

    respond_with @folder
  end

  private

    def folder_params
      params.require(:folder).permit(:name, :parent_id, :visible)
    end
end
