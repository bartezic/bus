#encoding: utf-8

module TicketsHelper
  def cities_for_select
    option_groups_from_collection_for_select(Country.all, :cities, :name, :id, :name)
  end

  def cities_for_select_js
    escape_javascript(option_groups_from_collection_for_select(Country.all, :cities, :name, :id, :name))
  end

  def cities_for_select_without(city_id)
    option_groups_from_collection_for_select(Country.where("id != ?", City.find(city_id).country.id), :cities, :name, :id, :name)
  end  

  def way(ticket, city_id, from)
    ticket.ways.where(
      :city_id => city_id, 
      :direction => !(from ^ (City.find(city_id).country.name == "Україна" ? true : false))
    ).first
  end
  def departure(ticket, date, city_id, from)
    ticket.departures.where(
      :departure_date_id => departure_date_id_from_date(date), 
      :direction => !(from ^ (City.find(city_id).country.name == "Україна" ? true : false))
    ).first
  end

  def to_time(time)
    time.to_s(:time) if time
  end

  def departure_date_id_from_date(date)
    day_of_life = Date.strptime(date, '%d/%m/%Y')
    DepartureDate.find_by_day_of_life(day_of_life).id
  end
end
