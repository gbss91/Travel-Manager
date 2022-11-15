# Decorator for flights. It decorates a model instance and allows to extract complex logic from the views
class FlightDecorator < BaseDecorator

  def flight_code
    carrier_code + flight_no
  end

  def departure
    departure_time.strftime("%R")
  end

  def arrival
    if departure_time.day == arrival_time.day
      arrival_time.strftime("%R")
    else
      arrival_time.strftime("%R+")
    end
  end

  def duration(duration)
    duration.strftime("%Hh%M")
  end
end
