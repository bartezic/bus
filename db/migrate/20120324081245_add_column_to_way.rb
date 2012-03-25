class AddColumnToWay < ActiveRecord::Migration
  def change
    add_column :ways, :place_stop, :string
    add_column :ways, :time_stop, :time
  end
end
