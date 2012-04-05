class CreateOneWayPrices < ActiveRecord::Migration
  def change
    create_table :one_way_prices do |t|
      t.integer :ticket_id
      t.integer :adult
      t.integer :child

      t.timestamps
    end
  end
end
