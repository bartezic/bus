class CreateTwoWaysVisaPrices < ActiveRecord::Migration
  def change
    create_table :two_ways_visa_prices do |t|
      t.integer :ticket_id
      t.integer :adult
      t.integer :child

      t.timestamps
    end
  end
end
