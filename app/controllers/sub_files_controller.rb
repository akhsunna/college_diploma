class SubFilesController < ApplicationController

  respond_to :html, :js

  def new
    @sub_file = SubFile.new
  end

  def create
    @subject = Subject.find(cookies[:current_subject])
    @sub_file = @subject.sub_files.create(file_params.merge(subject: @subject))
    redirect_to subject_path(id: @subject.id, parent: @sub_file.parent_id), notice: 'The file has been successfully created.'
  end

  def edit
    @sub_file = SubFile.find(params[:id])
  end

  def update
    @sub_files = SubFile.all
    @sub_file= SubFile.find(params[:id])
    @sub_file.update_attributes(file_params)
  end

  def delete
    @sub_file = SubFile.find(params[:sub_file_id])
  end

  def destroy
    @sub_files = SubFile.all
    @sub_file = SubFile.find(params[:id])
    @sub_file.destroy
  end

  private

  def file_params
    params.require(:sub_file).permit(:content, :parent_id)
  end

end
