class EventsGenerator

  def self.update_events
    new.update_events
  end

  def update_events
    start_time = (Date.current - 2.months).beginning_of_month
    end_time = (Date.current + 2.months).end_of_month
    latest_event = Event.last_event_between(start_time, end_time)
    if latest_event
      latest_event_time = latest_event.end_time.to_datetime
    else
      latest_event_time = start_time
    end
    if latest_event_time.to_date < end_time.to_date
      (latest_event_time..end_time).each do |date|
        add_events(date)
      end
    end
  end

  def add_events(date)
    rand_events_count.times do |i|
      start_time = rand_time(date)
      end_time = rand_time(start_time)

      event = Event.create(
        start_time: start_time,
        end_time: end_time,
        name: Faker::Company.bs
      )
      puts "JUST ADDED EVENT : #{event.id}"
    end
  end

  def rand_events_count
    base = 100
    (1..base).map do |i| 
      sub_arr = Array.new(base, i - 1)
      base = (base / i).to_i
      sub_arr
    end.flatten.sample
  end

  def rand_time(start_time = DateTime.current)
    (start_time + rand(1..8).hours).beginning_of_hour
  end
end
