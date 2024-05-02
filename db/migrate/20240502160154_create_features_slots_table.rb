class CreateFeaturesSlotsTable < ActiveRecord::Migration[7.1]
  def change
    create_table :features_slots do |t|
      t.belongs_to :slot, foreign_key: true
      t.belongs_to :feature, foreign_key: true

      t.timestamps
    end
  end
end
