class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :city_from_id
      t.integer :city_to_id
      t.integer :departure_from_id
      t.integer :departure_to_id
      t.boolean :one_way
      t.boolean :visa
      t.integer :adult
      t.integer :child
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
