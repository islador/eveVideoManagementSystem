class MissionPolicy
  attr_reader :user, :mission

  def initialize(user, mission)
    @user = user
    @mission = mission
  end

  def index?
    MissionGroupPolicy.new(@user, @mission.mission_group).show?
  end

  def new?
    @mission.creatable_by_user?(@user)
  end

  def create?
    @mission.creatable_by_user?(@user)
  end

  def show?
    @mission.accessible_to_user?(@user)
  end

  def edit?
    @mission.editable_by_user?(@user)
  end

  def update?
    @mission.editable_by_user?(@user)
  end

  def destroy?
    @mission.editable_by_user?(@user)
  end
end
