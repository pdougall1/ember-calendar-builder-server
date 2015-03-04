class Event < ActiveRecord::Base

  scope :between, -> (start_time, end_time) {
    where('start_time >= ? AND end_time <= ?', start_time, end_time)
  }
  scope :within, -> (month_date) {
    where('start_time >= ? AND end_time <= ?', month_date.beginning_of_day, month_date.end_of_month)
  }

  def self.last_event_between(start_time, end_time)
    events = between(start_time.to_datetime, end_time.to_datetime)
    events.max_by(&:end_time)
  end
end
