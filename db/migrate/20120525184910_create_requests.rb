class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :city_from_id
      t.integer :city_to_id
      t.boolean :one_way
      t.boolean :visa
      t.integer :adult
      t.integer :child
      t.string :name
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
