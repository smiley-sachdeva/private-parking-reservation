class AddReftokenToParkingLog < ActiveRecord::Migration[7.1]
  def change
    add_column :parking_logs, :ref_token, :string
  end
end
