class SubFilesController < ApplicationController

  respond_to :html, :js

  def new
    @sub_file = SubFile.new
  end

  def create
    @subject = Subject.find(cookies[:current_subject])
    @sub_file = @subject.sub_files.create(file_params.merge(subject: @subject))
    if @sub_file.save
      add_path_viewing @sub_file if @sub_file.format == 'document' || @sub_file.format == 'pdf'
      redirect_to subject_path(id: @subject.id, parent: @sub_file.parent_id), notice: 'The file has been successfully created.'
    else
      render action: 'new'
    end
  end

  def add_path_viewing(sub_file)
    if @sub_file.format == 'pdf'
      sub_file.path_viewing = sub_file.content.url.to_s
    else
      @path = sub_file.content.path.to_s.split('/')[0...-1].join('/')
      @url = sub_file.content.url.to_s.split('/')[0...-1].join('/')
      Docsplit.extract_pdf(sub_file.content.path.to_s, output: @path)
      @name = sub_file.name.split('.').first + '.pdf'
      sub_file.path_viewing = @url + '/' + @name
    end
    sub_file.save!
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

  def show
    @sub_file = SubFile.find(params[:id])
    if @sub_file.format == 'image'
      render 'sub_files/show/show_image'
    elsif @sub_file.format == 'video'
      render 'sub_files/show/show_video'
    elsif @sub_file.format == 'document' || @sub_file.format == 'pdf'
      render 'sub_files/show/show_doc'
    elsif @sub_file.format == 'code'
      render 'sub_files/show/show_code'
    else

    end
  end

  def favourite
    @sub_file = SubFile.find(params[:sub_file_id])
    if @sub_file.favourite? current_user
      # FavFolder.where(folder_id: @folder.id, user_id: current_user.id).first.destroy
      current_user.fav_files.find_by_sub_file_id(@sub_file.id).destroy
    else
      @fav_file = current_user.fav_files.create(sub_file_id: @sub_file.id)
    end

    respond_with @sub_file
  end

  def visible
    @sub_file = SubFile.find(params[:sub_file_id])
    @sub_file.visible = !@sub_file.visible
    @sub_file.save!
  end

  private

  def file_params
    params.require(:sub_file).permit(:content, :parent_id, :visible)
  end

end
