class UsersController < ApplicationController

  def main
    if user_signed_in?
      render current_user.teacher? ? 'users/teacher/home' : 'users/student/home'
    else
      redirect_to new_user_session_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end
end
