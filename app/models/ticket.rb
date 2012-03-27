class Ticket < ActiveRecord::Base
  belongs_to :carrier
  has_many :ways, :dependent => :destroy
  has_many :cities, :through => :ways

  has_many :departures, :dependent => :destroy
  has_many :departure_dates, :through => :departures

  accepts_nested_attributes_for :departures, :reject_if => proc { |atr| atr['departure_date_id'].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :ways, :reject_if => proc { |atr| atr['city_id'].blank? }, :allow_destroy => true

  attr_accessible :cities_from_ukr, :cities_to_ukr, :departure_dates_from_ukr, :departure_dates_to_ukr, :cities_from_ukr_detalies, :cities_to_ukr_detalies

  def self.search(params)
    includes(:carrier, :ways, :cities, :departures, :departure_dates).all
  end

  def cities_from_ukr
    h = Hash.new
    cities.map { |p| h[p.id] = p.name }
    ways.where(:direction => true).collect(&:city_id).map! { |i| i = h[i] } * ' - '
  end

  def cities_from_ukr_detalies
    h = Hash.new
    cities.map { |p| h[p.id] = p.name }
    "<table><tbody>
      <tr>
        <th>City</th>
        <th>Place</th>
        <th>Time</th>
      </tr>#{ways.where(:direction => true).map! { |i| 
      i = "<tr>
        <td>#{h[i.city_id]}</td>
        <td>#{i.place_stop}</td>
        <td>#{i.time_stop ? i.time_stop.strftime("%H:%M") : "-"}</td>
      </tr>" 
    }.join}</tbody></table>"
  end

  def cities_to_ukr
    h = Hash.new
    cities.map { |p| h[p.id] = p.name }
    ways.where(:direction => false).collect(&:city_id).map! { |i| i = h[i] } * ' - '
  end

  def cities_to_ukr_detalies
    h = Hash.new
    cities.map { |p| h[p.id] = p.name }
    "<table><tbody>
      <tr>
        <th>City</th>
        <th>Place</th>
        <th>Time</th>
      </tr>#{ways.where(:direction => false).map! { |i| 
      i = "<tr>
        <td>#{h[i.city_id]}</td>
        <td>#{i.place_stop}</td>
        <td>#{i.time_stop ? i.time_stop.strftime("%H:%M") : "-"}</td>
      </tr>" 
    }.join}</tbody></table>"
  end

  def departure_dates_from_ukr
    h,b,p = {},{},[]
    departure_dates.map { |p| h[p.id] = p.day_of_life }
    a = departures.where(:direction => true).collect(&:departure_date_id).map! { |i| i = h[i] }
    a.each {|i| b[i.year] = {}}
    a.each {|i| b[i.year][i.mon] = []}
    a.each {|i| b[i.year][i.mon] << i.day}
    b.each { |k,v| 
      p << "<tr><td>#{k}</td><td><td></tr>" 
      v.each { |key, val| 
        p << "<tr><td>#{key}</td><td>#{val.join(", ")}<td></tr>"
      }
    }
    "<table><tbody>
      #{p.join}
    </tbody></table>"
  end
  def departure_dates_to_ukr
    h,b,p = {},{},[]
    departure_dates.map { |p| h[p.id] = p.day_of_life }
    a = departures.where(:direction => false).collect(&:departure_date_id).map! { |i| i = h[i] }
    a.each {|i| b[i.year] = {}}
    a.each {|i| b[i.year][i.mon] = []}
    a.each {|i| b[i.year][i.mon] << i.day}
    b.each { |k,v| 
      p << "<tr><td>#{k}</td><td><td></tr>" 
      v.each { |key, val| 
        p << "<tr><td>#{key}</td><td>#{val.join(", ")}<td></tr>"
      }
    }
    "<table><tbody>
      #{p.join}
    </tbody></table>"
  end
  
  private

end
