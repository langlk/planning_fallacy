class GetCalendarEvent
  prepend SimpleCommand

  def initialize(account, event_id)
    @account = account
    @service = Google::Apis::CalendarV3::CalendarService.new
    @event_id = event_id
  end

  def call
    client_command = AuthRefreshAccess.call(@account)
    if client_command.success?
      @auth_client = client_command.result
      event = @service.get_event('primary', @event_id, options: { authorization: @auth_client })
      return event
    else
      errors.add(:refresh_error, 'could not refresh client')
      return nil
    end
  rescue Google::Apis::ClientError => exception
    errors.add(:client_error, exception.message)
    return nil
  rescue Google::Apis::AuthorizationError => exception
    errors.add(:client_error, 'unauthorized')
    return nil
  end
end
