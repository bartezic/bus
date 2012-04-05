class CreateHealthInsurances < ActiveRecord::Migration
  def change
    create_table :health_insurances do |t|
      t.integer :ticket_id
      t.integer :adult
      t.integer :child

      t.timestamps
    end
  end
end
