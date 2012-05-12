class DepartureDate < ActiveRecord::Base
  has_many :departures, :dependent => :destroy
  has_many :tickets, :through => :departures
  
  def self.new_day_in_day_of_life
    create!(:day_of_life => order("day_of_life ASC").last.day_of_life + 1)
  end
  def self.destroy_today_from_day_of_life
    where("day_of_life <= ?", Time.now.to_date).destroy_all
  end
end
