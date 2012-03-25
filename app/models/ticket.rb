class Ticket < ActiveRecord::Base
  belongs_to :carrier
  has_many :ways, :dependent => :destroy
  has_many :cities, :through => :ways

  has_many :departures, :dependent => :destroy
  has_many :departure_dates, :through => :departures

  accepts_nested_attributes_for :departures, :reject_if => proc { |atr| atr['departure_date_id'].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :ways, :reject_if => proc { |atr| atr['city_id'].blank? }, :allow_destroy => true
end
