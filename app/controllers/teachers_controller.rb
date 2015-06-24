class TeachersController < ApplicationController

  def index
    @teachers = User.teachers
    if user_signed_in?
      if current_user.admin?
        @invite_codes = InviteCode.where(role: 'teacher')
        render 'teachers/admin/index'
      else
        render 'teachers/user/index'
      end
    end
  end

  def delete
    @user = User.find(params[:teacher_id])
  end

  def destroy
    @users = User.all
    @user = User.find(params[:id])
    @user.destroy
  end

  def new_invite_code
    @invite_code = InviteCode.create(role: 'teacher', token: InviteCode.generate)
    redirect_to teachers_path
  end

  def delete_invite_codes
    InviteCode.where(role: 'teacher').destroy_all
    redirect_to teachers_path
  end

end
