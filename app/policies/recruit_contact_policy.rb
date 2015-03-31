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
end
