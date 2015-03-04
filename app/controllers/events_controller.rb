class EventsController < ApplicationController

  def index
    EventsGenerator.update_events
    if month_date
      render json: { events: Event.within(month_date) }
    else
      head :unprocessable_entity
    end
  end

  private

  def month_date
    @month_date ||= get_month_date
  end

  def get_month_date
    case 
    when params[:current_month]
      month_key = params[:current_month]
    when params[:currentMonth]
      month_key = params[:currentMonth]
    end
    DateTime.parse(month_key + "-01")
  end

end