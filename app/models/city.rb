class City < ActiveRecord::Base
	belongs_to :country
  has_many :carriers
  has_many :ways
  has_many :tickets, :through => :ways
end