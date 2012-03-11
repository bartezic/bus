class Ticket < ActiveRecord::Base
  has_many :ways
  has_many :cities, :through => :ways
end
