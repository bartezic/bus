class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :ways, :type, :direction
  end
end
