class RecruitContactPolicy
  attr_reader :user, :recruit_contact

  def initialize(user, recruit_contact)
    @user = user
    @recruit_contact = recruit_contact
  end

  def index?
    if user.roles["Corp Director"] || user.roles["Corp CEO"]
      return true
    else
      return false
    end
  end

  def create?
    if user.roles["Corp Director"] || user.roles["Corp CEO"]
      return true
    else
      return false
    end
  end

  def new?
    if user.roles["Corp Director"] || user.roles["Corp CEO"]
      return true
    else
      return false
    end
  end

  def edit?
    if user.roles["Corp Director"] || user.roles["Corp CEO"]
      return true
    else
      return false
    end
  end

  def show?
    if user.roles["Corp Director"] || user.roles["Corp CEO"]
      return true
    else
      return false
    end
  end

  def search_name?
    if user.roles["Corp Director"] || user.roles["Corp CEO"]
      return true
    else
      return false
    end
  end

  def update?
    if user.roles["Corp Director"] || user.roles["Corp CEO"]
      return true
    else
      return false
    end
  end

  def destroy?
    if user.roles["Corp Director"] || user.roles["Corp CEO"]
      return true
    else
      return false
    end
  end
end
