class CreateCarriers < ActiveRecord::Migration
  def change
    create_table :carriers do |t|
      t.string :name
      t.integer :city_id
      t.string :address
      t.string :phone
      t.string :telephone
      t.string :fax
      t.string :email
      t.string :web_site

      t.timestamps
    end
  end
end
