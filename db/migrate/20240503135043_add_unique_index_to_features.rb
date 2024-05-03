class AddUniqueIndexToFeatures < ActiveRecord::Migration[7.1]
  def change
    add_index :features, [:name, :parking_id], unique: true
  end
end
