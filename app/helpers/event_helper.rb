module EventHelper
  def check_in_button(event, user)
    if user.checked_in?(event)
      link_to 'Check Out', check_out_event_path(event), method: :delete
    elsif user.checked_out?(event)
      link_to 'Participated', event_path(event)
    else
      link_to 'Check In', check_in_event_path(event), method: :post
    end
  end
end
