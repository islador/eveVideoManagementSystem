class MissionGroupsController < ApplicationController
  def index
    authorize MissionGroup.new #current_user #MissionGroup.new()
    @mission_groups = MissionGroup.where("'#{current_user.id}' = ANY (participants)")
  end

  def create
    authorize MissionGroup.new
    @mission_group = MissionGroup.new(create_mission_group_params)
    # Set the mission group's creator
    @mission_group.user_id = current_user.id
    # Add the creator the group's participants for easy querying
    @mission_group.participants << Member.where("name = ?", current_user.main_character_name)[0].id
    @mission_group.participants.uniq!
    if @mission_group.save
      redirect_to mission_group_missions_path(@mission_group)
    else
      @members = Member.all
      render 'new'
    end
  end

  def new
    @mission_group = MissionGroup.new
    authorize @mission_group
    @members = Member.all
  end

  def edit
    @mission_group = MissionGroup.find(params[:id])
    authorize @mission_group
    @members = Member.all
    @selected_members = @mission_group.participants
  end

  def show
    authorize MissionGroup.find(params[:id])
    redirect_to mission_group_missions_path(params[:id])
  end

  def update
    @mission_group = MissionGroup.find(params[:id])
    authorize @mission_group
    # Allows the user to remove themselves from the participants list. Must fix.
    @mission_group.update_attributes(create_mission_group_params)
  end

  def destroy
    @mission_group = MissionGroup.find(params[:id])
    authorize @mission_group
    @mission_group.destroy
    redirect_to mission_groups_path
  end

  private
    def create_mission_group_params
      params.permit(:name, :participants => [])
    end
end
