class Api::V1::CheckinsController < Api::V1::ApiController
  def create
    event_command = GetCalendarEvent.call(current_account, params[:event_id])
    if event_command.success?
      event = event_command.result
      start_time = event.start.date_time ? event.start.date_time : event.start.date.to_datetime
      @checkin = current_account.checkins.new(event_id: event.id, event_time: start_time)
      if @checkin.save
        render json: { message: 'Checkin saved successfully.' }
      else
        render json: { error: 'Checkin could not be saved.'}
      end
    else
      render json: { error: 'Checkin could not be saved.'}
    end
  end
end
