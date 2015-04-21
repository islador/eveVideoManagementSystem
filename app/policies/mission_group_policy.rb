class MissionGroupPolicy
  attr_reader :user, :mission_group

  def initialize(user, mission_group)
    @user = user
    @mission_group = mission_group
  end

  def index?
    if @user.roles.pluck(:name).include?("Unknown")
      return false
    else
      return true
    end
  end

  def new?
    @mission_group.creatable_by_user?(@user)
  end

  def create?
    @mission_group.creatable_by_user?(@user)
  end

  def show?
    @mission_group.accessible_to_user?(@user)
  end

  def edit?
    @mission_group.editable_by_user?(@user)
  end

  def update?
    @mission_group.editable_by_user?(@user)
  end

  def destroy?
    @mission_group.editable_by_user?(@user)
  end
end
