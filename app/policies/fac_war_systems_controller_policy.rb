class FacWarSystemsControllerPolicy
  attr_reader :user, :controller

  def initialize(user, controller)
    @user = user
    @controller = controller
  end

  def index?
    roles = user.roles.pluck(:name)
    if roles.include?("Corp Director") || roles.include?("Corp CEO")
      return true
    else
      return false
    end
  end

  def refresh_fac_war_systems?
    roles = user.roles.pluck(:name)
    if roles.include?("Corp Director") || roles.include?("Corp CEO")
      return true
    else
      return false
    end
  end
end
