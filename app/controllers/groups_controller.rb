class GroupsController < ApplicationController

  def index
    @groups = Group.all
    @group = Group.new
  end

  def create
    @groups = Group.all
    @group = Group.create(group_params)
    redirect_to groups_path
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(group_params)
      redirect_to groups_path, notice: 'The group has been successfully updated.'
    else
      render action: 'edit'
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :course, :speciality_id)
  end

end
