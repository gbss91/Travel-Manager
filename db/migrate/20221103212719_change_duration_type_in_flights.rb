class ChangeDurationTypeInFlights < ActiveRecord::Migration[7.0]
  def change
    change_column :flights, :duration, :time
  end
end
