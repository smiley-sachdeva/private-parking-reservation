class Parking < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :open_time, presence: true
    validates :close_time, presence: true

    validate :open_time_before_close_time

    has_many :features

    # TODO Added parkingid to slot directly, so need to 
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
        errors.add(:base, "Opening time must be before closing time") if open_time > close_time
    end
end
