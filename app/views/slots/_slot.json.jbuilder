json.extract! slot, :id, :name, :price, :open_time, :close_time, :status, :created_at, :updated_at
json.parking parking.name
json.features slot.features.map(&:name)
json.url parking_slot_url(parking, slot, format: :json)
