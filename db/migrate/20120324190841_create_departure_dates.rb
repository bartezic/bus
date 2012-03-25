class CreateDepartureDates < ActiveRecord::Migration
  def change
    create_table :departure_dates do |t|
      t.date :day_of_life

      t.timestamps
    end
  end
end
