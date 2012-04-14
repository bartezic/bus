class DepartureDate < ActiveRecord::Base
  has_many :departures
  has_many :tickets, :through => :departures
  
  def self.new_day
    print "rrrr" * 100
    create!(:day_of_life => Time.now)
  end
end
