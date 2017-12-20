class GetCalendarEvents
  prepend SimpleCommand

  def initialize(event_id)
    @auth_client = AuthRefreshAccess.call(account).result
    @service = Google::Apis::CalendarV3::CalendarService.new
    @event_id = event_id
  end

  def call
    event = @service.get_event('primary', @event_id, options: { authorization: @auth_client })
    return event
  end
end
