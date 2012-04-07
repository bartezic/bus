class CreateWays < ActiveRecord::Migration
  def change
    create_table :ways do |t|
      t.integer :city_id
      t.integer :ticket_id
      t.boolean :type

      t.timestamps
    end
  end
end
