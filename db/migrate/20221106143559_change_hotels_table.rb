class ChangeHotelsTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :hotels, :hotel_brand
    remove_column :hotels, :check_in_time
    remove_column :hotels, :check_out_time
    remove_column :hotels, :board_type
    add_column :hotels, "room_type", :string, after: :check_in_date
  end
end
