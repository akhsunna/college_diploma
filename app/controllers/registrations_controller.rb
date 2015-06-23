class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters


  def create
    @role = params[:user][:role]
    if @role == 'student'
      @tokens = InviteCode.where(role: @role, group_id: params[:user][:group_id]).map{ |t| t.token}
    elsif @role == 'teacher'
      @tokens = InviteCode.where(role: @role).map{ |t| t.token}
    end

    if @tokens.include? params[:token]
      InviteCode.destroy_all(role: @role, token: params[:token])
      super
    else
      redirect_to(new_registration_path(resource_name), error: 'Invite code is invalid')
    end
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:name, :email, :password, :full_name, :group_id, :role, :token)
    devise_parameter_sanitizer.for(:account_update).push(:name, :email, :password, :full_name, :group_id)
  end
end
