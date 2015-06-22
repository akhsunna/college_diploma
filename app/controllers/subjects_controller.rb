class SubjectsController < ApplicationController

  def index
    if user_signed_in?
      if current_user.teacher?
        @subjects = Subject.where(user_id: current_user.id)
        render 'subjects/teacher/index'
      elsif current_user.student?
        @subjects = current_user.group.subjects.all
        render 'subjects/student/index'
      else
        @subjects = Subject.all
        render 'subjects/admin/index'
      end
    else
      redirect_to new_user_session_path
    end
  end

  def show
    @subject = Subject.find(params[:id])
    @parent = @subject.folders.find(params[:parent] || @subject.root_id)

    unless @parent.root?
      current_folder, @current_path = @parent, [@parent]
      while current_folder.parent_id != @subject.root_id
        @current_path.push(current_folder.parent)
        current_folder = current_folder.parent
      end
    end

    if current_user.teacher?
      @groups = Group.all
      @sub_groups = Subject.find(params[:id]).groups
      @folder = @subject.folders.new
      @sub_file = @subject.sub_files.new
      render 'subjects/teacher/show'
    else
      render 'subjects/student/show'
    end
    cookies[:current_subject] = @subject.id
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      add_root @subject
      redirect_to subjects_path, notice: 'The subject has been successfully created.'
    else
      render action: 'new'
    end
  end

  def add_root(subject)
    @folder = subject.folders.new(name: subject.short_name)
    @folder.save!
    subject.root_id = @folder.id
    subject.save!
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :short_name, :user_id)
  end
end
