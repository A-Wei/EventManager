module EventsHelper
  def creator?(user, event)
    event.user == user
  end

  def pretty_title(event)
    event.title.titleize
  end
end
