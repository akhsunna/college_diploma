class TeachersController < ApplicationController

  def index
    @teachers = User.teachers
  end

end
