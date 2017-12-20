class GetCalendarEvents
  prepend SimpleCommand

  def initialize(account)
    @auth_client = AuthRefreshAccess.call(account).result
    @service = Google::Apis::CalendarV3::CalendarService.new
  end

  def call
    response = @service.list_events(
      'primary',
      single_events: true,
      order_by: 'startTime',
      time_min: (Time.now - 12.hour).iso8601,
      time_max: (Time.now + 12.hour).iso8601,
      options: { authorization: @auth_client }
    )
    return response
  end
end
