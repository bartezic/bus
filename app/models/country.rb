class Country < ActiveRecord::Base
	default_scope :order => 'name ASC'
  has_many :cities

  def self.without(name)
    find(:all, :conditions => ["name != ?", name])
  end

  def self.cities_from(name)
    find_by_name(name)
  end
end
