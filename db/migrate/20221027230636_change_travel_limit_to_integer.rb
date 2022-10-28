class ChangeTravelLimitToInteger < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :travel_limit, :string
  end
end
