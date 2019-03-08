module EventHelper
  def check_in_button(event, user)
    if event.user_checked_in?(user)
      link_to 'Check Out', check_out_event_path(event), method: :delete
    elsif event.user_checked_out?(user)
      link_to 'Participated', event_path(event)
    else
      link_to 'Check In', check_in_event_path(event), method: :post
    end
  end
end
