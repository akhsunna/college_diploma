class StudentsController < ApplicationController

  respond_to :html, :js

  def index
    @students = User.students
    if user_signed_in?
      if !current_user.admin?
        render 'students/user/index'
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @users = User.all
    @user = User.find(params[:id])
    @user.update_attributes(student_params)
  end

  private

  def student_params
    params.require(:user).permit(:group_id)
  end

end
