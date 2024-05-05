json.extract! reservation, :id, :from, :to, :total_amount, :slot_id, :customer_id, :plate_number, :cancelled_at, :cancellation_amount, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
