class AddTravelLimitToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column(:users, :travel_limit, :float, null: true)
    add_column(:users, :currency, :float, null: true)
  end
end
