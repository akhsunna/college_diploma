class TeachersController < ApplicationController

  def index
    @teachers = User.teachers
    @invite_codes = InviteCode.where(role: 'teacher')
  end

  def new_invite_code
    @invite_code = InviteCode.create(role: 'teacher', token: 'token')
    redirect_to teachers_path
  end

  def delete_invite_codes
    InviteCode.where(role: 'teacher').destroy_all
    redirect_to teachers_path
  end

end
