class Way < ActiveRecord::Base
  default_scope :order => 'created_at ASC'
  belongs_to :city
  belongs_to :ticket
end
