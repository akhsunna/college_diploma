class StudentsController < ApplicationController

  respond_to :html, :js

  def index
    @students = User.students
    @groups = Group.all
    @specialities = Speciality.all
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
