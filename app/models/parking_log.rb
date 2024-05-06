class ParkingLog < ApplicationRecord
    belongs_to :reservation
    belongs_to :slot
end
