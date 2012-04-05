class RenameVisaTableToVisaPriceTable < ActiveRecord::Migration
  def change
    rename_table :visas, :visa_prices
  end
end
