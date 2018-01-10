class Api::V1::EventsController < Api::V1::ApiController

  def index
    events_command = GetCalendarEvents.call(current_account, 0, 24)
    if events_command.success?
      @events = events_command.result.items
      render json: { events: @events }
    else
      @events = []
      render json: {
        message: "There was a problem fetching your events",
        events: @events
      }
    end
  end
end
