class Way < ActiveRecord::Base
  belongs_to :city
  belongs_to :ticket
end
