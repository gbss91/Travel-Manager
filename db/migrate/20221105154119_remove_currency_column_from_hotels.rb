class RemoveCurrencyColumnFromHotels < ActiveRecord::Migration[7.0]
  def change
    remove_column :hotels, :currency
  end
end
