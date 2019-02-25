class EventPolicy < ApplicationPolicy
  def edit?
    user == record.user
  end
end
