class AddFieldsToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :date_from, :date
    add_column :requests, :date_to, :date
    add_column :requests, :notice, :string
  end
end
