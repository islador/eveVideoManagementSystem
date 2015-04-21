class MissionGroupsController < ApplicationController
  def index
    @mission_groups = MissionGroup.where("'#{current_user.id}' = ANY (participants)")
  end

  def create
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
  end

  def edit
  end

  def show
    redirect_to mission_group_missions_path(params[:id])
  end

  def update
  end

  def destroy
  end

  private
    def create_mission_group_params
      params.permit(:name)
    end
end
