class CreateVisas < ActiveRecord::Migration
  def change
    create_table :visas do |t|
      t.integer :ticket_id
      t.integer :adult
      t.integer :child

      t.timestamps
    end
  end
end
