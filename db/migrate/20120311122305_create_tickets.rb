class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :kod

      t.timestamps
    end
  end
end
