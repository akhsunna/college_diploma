class SubjectsController < ApplicationController
  def index

  end

  def show

  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)

    if @subject.save
      redirect_to user_path(current_user.id), notice: 'The article has been successfully created.'
    else
      render action: 'new'
    end
  end




  private

  def subject_params
    params.require(:subject).permit(:name, :short_name, :user_id)
  end
end
