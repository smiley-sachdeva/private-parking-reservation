class AddSlotIdToParkingLog < ActiveRecord::Migration[7.1]
  def change
    add_column :parking_logs, :slot_id, :integer
  end
end
