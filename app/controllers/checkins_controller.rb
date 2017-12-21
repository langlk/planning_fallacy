class CheckinsController < ApplicationController
  def new
    events_command = GetCalendarEvents.call(current_account, -3, 12)
    if events_command.success?
      @events = events_command.result.items
      @checkin = current_account.checkins.new
    else
      @events = []
      @checkin = current_account.checkins.new
      flash[:alert] = "There was a problem fetching your events."
    end
  end

  def create
    event_command = GetCalendarEvent.call(current_account, params[:checkin][:event_id])
    if event_command.success?
      event = event_command.result
      @checkin = current_account.checkins.new(event_id: event.id, event_time: event.start.date_time)
      if @checkin.save
        flash[:notice] = "You've checked in successfully!"
        redirect_to root_path
      else
        flash[:alert] = @checkin.errors.full_messages
        render :new
      end
    else
      flash[:alert] = "Checkin could not be saved."
      redirect_to '/checkin'
    end
  end
end
