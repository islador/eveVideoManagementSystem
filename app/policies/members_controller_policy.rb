class MembersControllerPolicy
  attr_reader :user, :controller

  def initialize(user, controller)
    @user = user
    @controller = controller
  end

  def add_new_api?
    roles = user.roles.pluck(:name)
    if roles.include?("Corp Director") || roles.include?("Corp CEO")
      return true
    else
      return false
    end
  end

  def add_temporary_member?
    roles = user.roles.pluck(:name)
    if roles.include?("Corp Director") || roles.include?("Corp CEO")
      return true
    else
      return false
    end
  end

  def refresh_member_list?
    roles = user.roles.pluck(:name)
    if roles.include?("Corp Director") || roles.include?("Corp CEO")
      return true
    else
      return false
    end
  end

  def index?
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

  def create?
    roles = user.roles.pluck(:name)
    if roles.include?("Corp Director") || roles.include?("Corp CEO")
      return true
    else
      return false
    end
  end


end
