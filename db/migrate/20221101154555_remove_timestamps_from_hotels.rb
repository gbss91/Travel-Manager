class RemoveTimestampsFromHotels < ActiveRecord::Migration[7.0]
  def change
    remove_column :hotels, :created_at, :string
    remove_column :hotels, :updated_at, :string
  end
end
