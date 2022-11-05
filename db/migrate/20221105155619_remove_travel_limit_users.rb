class RemoveTravelLimitUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :travel_limit
    remove_column :users, :currency
  end
end
