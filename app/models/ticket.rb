class Ticket < ActiveRecord::Base
  attr_accessible :kod, :ways_attributes
  
  has_many :ways, :dependent => :destroy
  has_many :cities, :through => :ways
  accepts_nested_attributes_for :ways
end
