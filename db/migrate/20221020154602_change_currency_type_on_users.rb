class ChangeCurrencyTypeOnUsers < ActiveRecord::Migration[7.0]
  def change
    change_column(:users, :currency, :string)
  end
end
