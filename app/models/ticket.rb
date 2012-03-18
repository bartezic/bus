class Ticket < ActiveRecord::Base
  has_many :ways, :dependent => :destroy
  has_many :cities, :through => :ways
  accepts_nested_attributes_for :ways, :reject_if => proc { |attributes| attributes['city_id'].blank? }, :allow_destroy => true
end
