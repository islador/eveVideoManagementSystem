class MissionGroupsController < ApplicationController
  def index
    authorize MissionGroup.new
    member_ids = current_user.members.pluck(:id)
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
    owners_members = current_user.members.pluck(:name)
    @members = Member.where("name NOT IN (?)", owners_members)
    @selected_members = @mission_group.participants
  end

  def show
    authorize MissionGroup.find(params[:id])
    redirect_to mission_group_missions_path(params[:id])
  end

  def update
    # Authorize the update of the group
    @mission_group = MissionGroup.find(params[:id])
    authorize @mission_group
    # Copy the participants array before updating it.
    old_participants = Array.new(@mission_group.participants)
    # Extract out the required params and update them
    @mission_group.name = params[:name]
    # Ensure that a user sending an empty participants array clears participants as desired.
    unless params[:participants].nil?
      @mission_group.participants = params[:participants]
    else
      @mission_group.participants = []
    end

    # Ensure the owning user is always added to the participants array
    # Extract it from the database, turn it into a string and push it into the participants array.
    owner_member_id = Member.where(name: @mission_group.user.main_character_name).pluck(:id)
    owner_member_id = owner_member_id[0].to_s
    @mission_group.participants << owner_member_id

    # Compare the old and new participants array
    old_participants.each do |old_participant|
      # If an old participant isn't in the new array
      if !@mission_group.participants.include?(old_participant)
        # Remove its missions from the group.
        old_participant_user = Member.find(old_participant).user
        if old_participant_user
          # Note: This bulk delete does not fire active record callbacks.
          @mission_group.missions.where("user_id = ?", Member.find(old_participant).user.id).destroy_all
        end
      end
    end

    # Save and redirect
    @mission_group.save
    redirect_to mission_group_path(@mission_group)
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
