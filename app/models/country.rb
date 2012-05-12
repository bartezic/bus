class Country < ActiveRecord::Base
	default_scope :order => 'name ASC'
  has_many :cities
end
