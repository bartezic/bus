class AddCarrierIdToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :carrier_id, :integer
  end
end
