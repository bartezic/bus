class Departure < ActiveRecord::Base
  belongs_to :departure_date
  belongs_to :ticket
end
