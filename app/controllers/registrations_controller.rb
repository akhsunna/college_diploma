class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:name, :email, :password, :full_name, :group_id, :status)
    devise_parameter_sanitizer.for(:account_update).push(:name, :email, :password, :full_name, :group_id, :status)
  end
end
