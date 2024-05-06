class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.datetime :from
      t.datetime :to
      t.float :total_amount
      t.integer :slot_id
      t.integer :customer_id
      t.string :plate_number
      t.datetime :cancelled_at
      t.float :cancellation_amount

      t.timestamps
    end
  end
end
