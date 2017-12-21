class GetCalendarEvents
  prepend SimpleCommand

  def initialize(account, min_time, max_time)
    # parsing the time from a string is primarily meant for testing, since calculating from the current time on each test call does not cooperate well with vcr.
    @min_time = min_time.class == String ?
      Time.parse(min_time).iso8601 : (Time.now + min_time.hour).iso8601
    @max_time = max_time.class == String ?
      Time.parse(max_time).iso8601 : (Time.now + max_time.hour).iso8601
    @account = account
    @service = Google::Apis::CalendarV3::CalendarService.new
  end

  def call
    client_command = AuthRefreshAccess.call(@account)
    if client_command.success?
      @auth_client = client_command.result
      response = @service.list_events(
        'primary',
        single_events: true,
        order_by: 'startTime',
        time_min: @min_time,
        time_max: @max_time,
        options: { authorization: @auth_client }
      )
      return response
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
