class ChangeRateToDecimal < ActiveRecord::Migration[7.0]
  def change
    change_column :hotels, :rate, :decimal, precision: 10, scale: 2, null: false
  end
end
