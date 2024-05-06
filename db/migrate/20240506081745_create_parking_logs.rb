class CreateParkingLogs < ActiveRecord::Migration[7.1]
  def change
    create_table :parking_logs do |t|
      t.datetime :checkin_time
      t.datetime :checkout_time
      t.float :duration
      t.float :price
      t.string :plate_number
      t.integer :reservation_id

      t.timestamps
    end
  end
end
