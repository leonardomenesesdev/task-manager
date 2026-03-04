class CategoryPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  def show?
    Rails.logger.debug "USER: #{user.id}"
    Rails.logger.debug "RECORD USER: #{record.user_id}"
    record.user == user
  end
  def update?
    record.user == user
  end
  def destroy?
    record.user == user
  end
  def edit?
    update?
  end
end
