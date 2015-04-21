class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to user_path(current_user.id)
    else
      redirect_to new_user_session_path
    end
  end
end
