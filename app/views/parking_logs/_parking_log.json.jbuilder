json.extract! parking_log, :id, :checkin_time, :checkout_time, :ref_token,:duration, :price, :plate_number, :reservation_id, :created_at, :updated_at
json.slot slot.name
json.url slot_parking_logs_url(slot, parking_log, format: :json)
