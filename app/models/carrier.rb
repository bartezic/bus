class Carrier < ActiveRecord::Base
  belongs_to :city
  has_many :tickets
end
