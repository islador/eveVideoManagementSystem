class FittingPolicy
  attr_reader :user, :fitting

  def initialize(user, fitting)
    @user = user
    @fitting = fitting
  end

  def index?
    DoctrinePolicy.new(@user, @fitting.doctrine).show?
  end

  def create?
    DoctrinePolicy.new(@user, @fitting.doctrine).create?
  end

  def new?
    DoctrinePolicy.new(@user, @fitting.doctrine).new?
  end

  def edit?
    DoctrinePolicy.new(@user, @fitting.doctrine).edit?
  end

  def show?
    DoctrinePolicy.new(@user, @fitting.doctrine).show?
  end

  def update?
    DoctrinePolicy.new(@user, @fitting.doctrine).update?
  end

  def destroy?
    DoctrinePolicy.new(@user, @fitting.doctrine).destroy?
  end
end
