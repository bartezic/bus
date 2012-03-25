class CreateDepartures < ActiveRecord::Migration
  def change
    create_table :departures do |t|
      t.string :trip_number
      t.integer :departure_date_id
      t.integer :ticket_id
      t.boolean :direction

      t.timestamps
    end
  end
end
