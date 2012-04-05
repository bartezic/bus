class Ticket < ActiveRecord::Base
  belongs_to :carrier
  
  has_one :one_way_price
  has_one :one_way_visa_price
  has_one :two_ways_price
  has_one :two_ways_visa_price
  has_one :visa_price
  has_one :health_insurance_price

  has_many :ways, :dependent => :destroy
  has_many :cities, :through => :ways

  has_many :departures, :dependent => :destroy
  has_many :departure_dates, :through => :departures

  accepts_nested_attributes_for :health_insurance_price, :reject_if => proc { |atr| atr['adult'].blank? }
  accepts_nested_attributes_for :visa_price, :reject_if => proc { |atr| atr['adult'].blank? }
  accepts_nested_attributes_for :one_way_price, :reject_if => proc { |atr| atr['adult'].blank? }
  accepts_nested_attributes_for :one_way_visa_price, :reject_if => proc { |atr| atr['adult'].blank? }
  accepts_nested_attributes_for :two_ways_price, :reject_if => proc { |atr| atr['adult'].blank? }
  accepts_nested_attributes_for :two_ways_visa_price, :reject_if => proc { |atr| atr['adult'].blank? }
  accepts_nested_attributes_for :departures, :reject_if => proc { |atr| atr['departure_date_id'].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :ways, :reject_if => proc { |atr| atr['city_id'].blank? }, :allow_destroy => true

  attr_reader :marshrut, :marshrut_with_detalies, :prt_departure_dates

  def self.search(params)
    if params[:one_way] == "true"
      one_way_search(params)
    else
      two_ways_search(params)
    end
  end

  def marshrut(from)
    h = Hash.new
    cities.map { |p| h[p.id] = p.name }
    ways.where(:direction => from).collect(&:city_id).map! { |i| i = h[i] } * ' - '
  end

  def marshrut_with_detalies(from)
    h = Hash.new
    cities.map { |p| h[p.id] = p.name }
    "<table><tbody>
      #{ways.where(:direction => from).map! { |i| 
      i = "<tr>
        <td>#{h[i.city_id]}</td>
        <td>#{i.place_stop}</td>
        <td>#{i.time_stop ? i.time_stop.strftime("%H:%M") : "-"}</td>
      </tr>" 
    }.join}</tbody></table>"
  end

  def prt_departure_dates(from)
    mon = Date::MONTHNAMES.compact
    h,b,p = {},{},[]
    departure_dates.map { |p| h[p.id] = p.day_of_life }
    a = departures.where(:direction => from).collect(&:departure_date_id).map! { |i| i = h[i] }
    a.each {|i| b[i.year] = {}}
    a.each {|i| b[i.year][i.mon] = []}
    a.each {|i| b[i.year][i.mon] << i.day}
    b.each { |k,v| 
      p << "<p><b>#{k}</b></p>" 
      v.each { |key, val| 
        p << "<p><i>#{mon[key-1]}</i> - #{val.join(", ")}</p>"
      }
    }
   p.join
  end
  
  private

  def self.one_way_search(params)
    result = params[:city_from].blank? ? all : ticket_where_city(params[:city_from], true)
    result2 = params[:city_to].blank? ? all : ticket_where_city(params[:city_to], true)
    result & result2 &
    find(Departure.where(
      :direction => true, 
      :departure_date_id => departure_date_id_from_date(params[:date_from])
    ).collect(&:ticket_id))
  end

  def self.ticket_where_city(city_id, from)
    find(Way.where(:direction => from, :city_id => city_id).collect(&:ticket_id))
  end

  def self.departure_date_id_from_date(day)
    DepartureDate.find_by_day_of_life(Date.strptime(day, '%d/%m/%Y')).id
  end

  def self.two_ways_search(params)
    all
  end
end
