class UsersController < ApplicationController

  def main
    if user_signed_in?
      render 'users/teacher/home' if current_user.teacher?
      render 'users/student/home' if current_user.student?
      render 'users/admin/home' if current_user.admin?
    else
      redirect_to new_user_session_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    if current_user.admin?
      @students = User.students
      @teachers = User.teachers
      @groups = Group.all
      @users = User.all
      @specialities = Speciality.all
      render 'users/admin/index'
    else
      @users = User.all
    end



  end
end
