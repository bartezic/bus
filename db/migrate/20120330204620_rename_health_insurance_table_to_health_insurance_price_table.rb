class RenameHealthInsuranceTableToHealthInsurancePriceTable < ActiveRecord::Migration
  def change
    rename_table :health_insurances, :health_insurance_prices
  end
end
