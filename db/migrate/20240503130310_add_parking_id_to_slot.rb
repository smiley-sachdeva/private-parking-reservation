class AddParkingIdToSlot < ActiveRecord::Migration[7.1]
  def change
    add_reference :slots, :parking, foreign_key: true
  end
end
