class RemoveTimestampsFromFlights < ActiveRecord::Migration[7.0]
  def change
    remove_column :flights, :created_at, :string
    remove_column :flights, :updated_at, :string
  end
end
