class SubjectsController < ApplicationController

  def index
    if current_user.teacher?
      @subjects = Subject.where(user_id: current_user.id)
      render 'subjects/teacher/index'
    else
      @subjects = current_user.group.subjects.all
      render 'subjects/student/index'
    end
  end

  def show
    @subject = Subject.find(params[:id])
    if current_user.teacher?
      @groups = Subject.find(params[:id]).groups
      @folder = @subject.items.new
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
      redirect_to user_path(current_user.id), notice: 'The subject has been successfully created.'
    else
      render action: 'new'
    end
  end

  def add_root(subject)
    @item = subject.items.new(name: subject.short_name)
    @item.save!
    subject.root_id = @item.id
    subject.save!
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :short_name, :user_id)
  end
end
