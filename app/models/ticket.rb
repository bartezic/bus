class Ticket < ActiveRecord::Base
  has_many :ways, :dependent => :destroy
  has_many :cities, :through => :ways
  accepts_nested_attributes_for :ways
end
