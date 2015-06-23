class SubFilesController < ApplicationController

  respond_to :html, :js

  require 'fileutils'

  def new
    @sub_file = SubFile.new
  end

  def create
    @subject = Subject.find(cookies[:current_subject])
    @sub_file = @subject.sub_files.create(file_params.merge(subject: @subject))
    if @sub_file.save
      add_path_viewing @sub_file if ['document','pdf','presentation'].include?(@sub_file.format)
      redirect_to subject_path(id: @subject.id, parent: @sub_file.parent_id), notice: 'The file has been successfully created.'
    else
      render action: 'new'
    end
  end

  def add_path_viewing(sub_file)
    if @sub_file.format == 'pdf'
      sub_file.path_viewing = sub_file.content.url.to_s
    elsif @sub_file.format == 'document'
      @path = sub_file.content.path.to_s.split('/')[0...-1].join('/')
      @url = sub_file.content.url.to_s.split('/')[0...-1].join('/')
      Docsplit.extract_pdf(sub_file.content.path.to_s, output: @path)
      @name = sub_file.name.split('.').first + '.pdf'
      sub_file.path_viewing = @url + '/' + @name
    else
      @name = sub_file.name.split('.').first
      @path = sub_file.content.path.to_s.split('/')[0...-1].join('/') + '/' + @name
      @url = sub_file.content.url.to_s.split('/')[0...-1].join('/') + '/' + @name
      sub_file.path_viewing = @url
      Docsplit.extract_images(sub_file.content.path.to_s, size: '550x', format: [:jpg], output: @path)
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
    FileUtils.rm_r(@sub_file.content.path.to_s.split('/')[0...-1].join('/'))
    @sub_file.destroy
  end

  def show
    @sub_file = SubFile.find(params[:id])
    @parent = @sub_file.parent
    @subject = Subject.find(cookies[:current_subject])

    unless @parent.root?
      @current_folder, @current_path = @parent, [@parent]
      while @current_folder.parent_id != @subject.root_id
        @current_path.push(@current_folder.parent)
        @current_folder = @current_folder.parent
      end
    end

    if @sub_file.format == 'image'
      render 'sub_files/show/show_image'
    elsif @sub_file.format == 'video'
      render 'sub_files/show/show_video'
    elsif @sub_file.format == 'document' || @sub_file.format == 'pdf'
      render 'sub_files/show/show_doc'
    elsif @sub_file.format == 'code'
      render 'sub_files/show/show_code'
    elsif @sub_file.format == 'presentation'
      @slides = Dir.glob("#{Rails.root}/public" + @sub_file.path_viewing + '/*')
      @slides.sort_by {|slide| File.mtime(slide) }
      @slides.map!{|item| item=item.partition("public")[2]}
      render 'sub_files/show/show_presentation'
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
