module EventsHelper
  def creator?(user, event)
    event.user == user
  end
end
