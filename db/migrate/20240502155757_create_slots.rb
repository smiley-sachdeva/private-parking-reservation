class CreateSlots < ActiveRecord::Migration[7.1]
  def change
    create_table :slots do |t|
      t.string :name
      t.float :price
      t.time :open_time
      t.time :close_time
      t.integer :status

      t.timestamps
    end
  end
end
