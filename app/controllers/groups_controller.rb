class GroupsController < ApplicationController

  respond_to :html, :js

  def show
    @group = Group.find(params[:id])
    @students = @group.users
  end

  def index
    @groups = Group.all
    @group = Group.new
  end

  def create
    @groups = Group.all
    @group = Group.create(group_params)
    redirect_to groups_path
  end

  def invite_codes
    @group = Group.find(params[:group_id])
    @invite_codes = InviteCode.where(group_id: @group.id)
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(group_params)
      redirect_to groups_path, notice: 'The group has been successfully updated.'
    else
      render action: 'new'
    end
  end

  def subject
    @group = Group.find(params[:group_id])
    @subject = Subject.find(cookies[:current_subject])
    if @group.access? @subject
      GroupSubject.where(group_id: @group.id, subject_id: @subject.id).first.destroy
    else
      @new_group_subject = @subject.group_subjects.create(group_id: @group.id)
    end
    respond_with @group
  end

  private

  def group_params
    params.require(:group).permit(:name, :course, :speciality_id)
  end

end
