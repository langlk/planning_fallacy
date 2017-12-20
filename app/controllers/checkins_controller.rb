class CheckinsController < ApplicationController
  def new
    @events = GetCalendarEvents.call(current_account).result.items
    @checkin = current_account.checkins.new
  end

  def create
    @checkin = current_account.checkins.new(checkin_params)
    if @checkin.save
      flash[:notice] = "You've checked in successfully!"
      redirect_to root_path
    else
      flash[:alert] = @checkin.errors.full_messages
      render :new
    end
  end

  private

  def checkin_params
    params.require(:checkin).permit(:name, :event_time, :lateness)
  end
end
