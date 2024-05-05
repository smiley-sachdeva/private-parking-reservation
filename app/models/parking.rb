class Parking < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :open_time, presence: true#, format: { with: /\A\d{2}:\d{2}\z/, message: "format should be HH:MM" }
    validates :close_time, presence: true#, format: { with: /\A\d{2}:\d{2}\z/, message: "format should be HH:MM" }

    validate :open_time_before_close_time

    has_many :features

    # TODO Added parkingid to slot directly, so no need to 
    # add complex query to fetch parking slots

    # has_many :slots, through: :features
    
    has_many :slots

    def open_time
        read_attribute(:open_time)&.strftime("%H:%M:%S")
    end

    def close_time
        read_attribute(:close_time)&.strftime("%H:%M:%S")
    end

    private
    def open_time_before_close_time
        errors.add(:base, "Opening time must be before closing time") \
            if open_time && close_time && open_time > close_time
    end
end
