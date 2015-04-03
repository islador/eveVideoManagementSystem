class DoctrinePolicy
  attr_reader :user, :doctrine

  def initialize(user, doctrine)
    @user = user
    @doctrine = doctrine
  end

  def new?
    @doctrine.creatable_by_user?(@user)
  end

  def create?
    @doctrine.creatable_by_user?(@user)
  end

  def show?
    @doctrine.accessible_to_user?(@user)
  end

  def edit?
    @doctrine.editable_by_user?(@user)
  end

  def update?
    @doctrine.editable_by_user?(@user)
  end

  def destroy?
    @doctrine.editable_by_user?(@user)
  end
end
