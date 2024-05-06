class Slot < ApplicationRecord
    has_and_belongs_to_many :features
    belongs_to :parking
    has_many :reservations

    enum status: {
        available: 0,
        booked: 1,
        closed: 2
      }

    # Validate slot name w.r.t parking
    # For example, slot name must be unique within that parking 
    # parking 1 => slot1, slot2 is valid
    # parking 2 => slot1, slot2 is valid

    validates :name, presence: true,uniqueness: { 
            scope: :parking_id, 
            message: "must be unique within the parking" 
        }

    validates :open_time, presence: true#, format: { with: /\A\d{2}:\d{2}\z/, message: "format should be HH:MM" }
    validates :close_time, presence: true#, format: { with: /\A\d{2}:\d{2}\z/, message: "format should be HH:MM" }
    validate :validate_opening_and_closing_times
    validate :validate_timings_respective_to_parking

    # validates :features, presence: true

    after_initialize :set_default_status, if: :new_record?

    def open_time
        read_attribute(:open_time)&.strftime("%H:%M:%S")
    end

    def close_time
        read_attribute(:close_time)&.strftime("%H:%M:%S")
    end

    private

    def set_default_status
        self.status ||= default_status
    end
    
    def default_status
        if open_time && close_time && Time.current.strftime("%H:%M:%S").between?(open_time, close_time)
            :available
        else
            :closed
        end
    end
    
    def validate_timings_respective_to_parking 
        errors.add(:base, "Opening time must be on or after parking's opening time") \
            unless open_time >= parking.open_time
        errors.add(:base, "Closing time must be before or on parking's closing time") \
            unless close_time <= parking.close_time
    end

    def validate_opening_and_closing_times
        errors.add(:base, "Opening time must be before closing time") \
            if open_time && close_time && open_time >= close_time
    end
end
