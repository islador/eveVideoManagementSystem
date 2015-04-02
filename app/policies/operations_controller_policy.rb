class OperationsControllerPolicy
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

  def create?
    roles = user.roles.pluck(:name)
    if roles.include?("Corp Director") || roles.include?("Corp CEO")
      return true
    else
      return false
    end
  end

  def new?
    roles = user.roles.pluck(:name)
    if roles.include?("Corp Director") || roles.include?("Corp CEO")
      return true
    else
      return false
    end
  end

  def show?
    roles = user.roles.pluck(:name)
    if roles.include?("Corp Director") || roles.include?("Corp CEO")
      return true
    else
      return false
    end
  end

  def update?
    roles = user.roles.pluck(:name)
    if roles.include?("Corp Director") || roles.include?("Corp CEO")
      return true
    else
      return false
    end
  end

  def destroy?
    roles = user.roles.pluck(:name)
    if roles.include?("Corp Director") || roles.include?("Corp CEO")
      return true
    else
      return false
    end
  end
end
