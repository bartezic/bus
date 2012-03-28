class Ticket < ActiveRecord::Base
  belongs_to :carrier
  has_many :ways, :dependent => :destroy
  has_many :cities, :through => :ways

  has_many :departures, :dependent => :destroy
  has_many :departure_dates, :through => :departures

  accepts_nested_attributes_for :departures, :reject_if => proc { |atr| atr['departure_date_id'].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :ways, :reject_if => proc { |atr| atr['city_id'].blank? }, :allow_destroy => true

  attr_accessible :marshrut, :marshrut_with_detalies, :prt_departure_dates

  def self.search(params)
    includes(:carrier, :ways, :cities, :departures, :departure_dates).all
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

end
