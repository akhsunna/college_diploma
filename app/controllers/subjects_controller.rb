class SubjectsController < ApplicationController
  def index
    if current_user.teacher?
      @subjects = Subject.where(user_id: current_user.id)
      render 'subjects/teacher/index'
    else
      @subjects = Subject.all
      render 'subjects/student/index'
    end
  end

  def show
    @subject = Subject.find(params[:id])
    @groups = Subject.groups
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)

    if @subject.save
      redirect_to user_path(current_user.id), notice: 'The subject has been successfully created.'
    else
      render action: 'new'
    end
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :short_name, :user_id)
  end
end
