class AddParkingIdToFeatures < ActiveRecord::Migration[7.1]
  def change
    add_reference :features, :parking, foreign_key: true
  end
end
