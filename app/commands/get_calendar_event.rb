class GetCalendarEvent
  prepend SimpleCommand

  def initialize(account, event_id)
    @auth_client = AuthRefreshAccess.call(account).result
    @service = Google::Apis::CalendarV3::CalendarService.new
    @event_id = event_id
  end

  def call
    event = @service.get_event('primary', @event_id, options: { authorization: @auth_client })
    return event
  rescue Google::Apis::ClientError => exception
    if exception.status_code == 404
      errors.add(:event, "not found")
    else
      errors.add(:client_error, exception.message)
    end
    return nil
  rescue Google::Apis::AuthorizationError => exception
    errors.add(:client_error, 'unauthorized')
    return nil
  end
end
