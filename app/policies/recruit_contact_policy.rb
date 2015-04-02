class RecruitContactPolicy
  attr_reader :user, :recruit_contact

  def initialize(user, recruit_contact)
    @user = user
    @recruit_contact = recruit_contact
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

  def edit?
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

  def search_name?
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
