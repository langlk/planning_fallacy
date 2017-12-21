class GetCalendarEvents
  prepend SimpleCommand

  def initialize(account, min_time, max_time)
    @min_time = min_time
    @max_time = max_time
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
        time_min: (Time.now + (@min_time).hour).iso8601,
        time_max: (Time.now + (@max_time).hour).iso8601,
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
