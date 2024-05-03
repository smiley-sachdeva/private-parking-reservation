class AddUniqueIndexToSlot < ActiveRecord::Migration[7.1]
  def change
    add_index :slots, [:name, :parking_id], unique: true
  end
end
