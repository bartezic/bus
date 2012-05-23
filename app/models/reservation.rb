class Reservation < ActiveRecord::Base
  belongs_to :city_from, :class_name => "City"
  belongs_to :city_to, :class_name => "City"
  belongs_to :departure_from, :class_name => "Departure"
  belongs_to :departure_to, :class_name => "Departure"
end
