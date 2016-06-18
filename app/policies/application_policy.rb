class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    true
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    user
  end

  def new?
    create?
  end

  def update?
    has_permision_for_this?
  end

  def edit?
    update?
  end

  def destroy?
    has_permision_for_this?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end

  private

  def has_permision_for_this?
    user && (user.id == record.user_id || user.admin?)
  end
end
