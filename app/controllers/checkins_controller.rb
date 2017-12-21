class CheckinsController < ApplicationController
  def new
    @events = GetCalendarEvents.call(current_account).result.items
    @checkin = current_account.checkins.new
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
