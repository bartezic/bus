module TicketsHelper
  def cities_for_select
    option_groups_from_collection_for_select(Country.all, :cities, :name, :id, :name)
  end
  def time_stop(ticket, city_id)
    time = ticket.ways.where(:city_id => city_id).first.time_stop
    time.to_s(:time) if time
  end
  def place_stop(ticket, city_id)
    ticket.ways.where(:city_id => city_id).first.place_stop 
  end
  def trip_number(ticket, date)
    day_of_life = Date.strptime(date, '%d/%m/%Y')
    ticket.departures.where(:departure_date_id => DepartureDate.find_by_day_of_life(day_of_life).id).first.trip_number 
  end
end
