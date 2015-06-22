class SpecialitiesController < ApplicationController

  respond_to :html, :js

  def index
    @specialities = Speciality.all
    @speciality = Speciality.new
  end

  def new
    @speciality = Speciality.new
  end

  def create
    @specialities = Speciality.all
    @speciality = Speciality.create(speciality_params)
    redirect_to specialities_path, notice: 'The speciality has been successfully created.'
  end

  def edit
    @speciality = Speciality.find(params[:id])
  end

  def update
    @specialities = Speciality.all
    @speciality = Speciality.find(params[:id])
    @speciality.update_attributes(speciality_params)
  end

  def delete
    @speciality = Speciality.find(params[:speciality_id])
  end

  def destroy
    @specialities = Speciality.all
    @speciality = Speciality.find(params[:id])
    @speciality.destroy
  end

  private

  def speciality_params
    params.require(:speciality).permit(:name, :short_name)
  end

end
