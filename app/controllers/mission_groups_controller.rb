class MissionGroupsController < ApplicationController
  def index
    authorize MissionGroup.new #current_user #MissionGroup.new()
    @mission_groups = MissionGroup.where("'#{current_user.id}' = ANY (participants)")
  end

  def create
    authorize MissionGroup.new
    @mission_group = MissionGroup.create(create_mission_group_params)
    # Set the mission group's creator
    @mission_group.user_id = current_user.id
    # Add the creator the group's participants for easy querying
    @mission_group.participants << current_user.id
    if @mission_group.save
      redirect_to mission_group_missions_path(@mission_group)
    else
      flash[:alert] = "You shouldn't ever see this. Take a screenshot and email it to issy"
      render 'new'
    end
  end

  def new
    @mission_group = MissionGroup.new
    authorize @mission_group
  end

  def edit
    @mission_group = MissionGroup.find(params[:id])
    authorize @mission_group
  end

  def show
    authorize MissionGroup.find(params[:id])
    redirect_to mission_group_missions_path(params[:id])
  end

  def update
    @mission_group = MissionGroup.find(params[:id])
    authorize @mission_group
    @mission_group.update_attributes(create_mission_group_params)
  end

  def destroy
    @mission_group = MissionGroup.find(params[:id])
    authorize @mission_group
    @mission_group.destroy
  end

  private
    def create_mission_group_params
      params.permit(:name)
    end
end
