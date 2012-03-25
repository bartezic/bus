class DepartureDate < ActiveRecord::Base
  has_many :departures
  has_many :tickets, :through => :departures
end
