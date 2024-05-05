class Reservation < ApplicationRecord
    attr_accessor :total_hours

    belongs_to :slot
    belongs_to :customer, class_name: 'User', foreign_key: 'customer_id'

    validates :to, :from, presence: true, future: true#,  format: { with: /\A\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}Z\z/,
    #message: "format should be YYYY-MM-DD HH:MM:SS" }

    validate :timings_witihin_day?
    validate :validate_from_and_to_time
    validate :validate_timings_respective_to_slot

    def to_time
        to.strftime("%H:%M:%S")
    end

    def from_time
        from.strftime("%H:%M:%S")
    end

    def total_hours
        (to.to_i - from.to_i)/1.hour
    end

    private
    def timings_witihin_day?
        errors.add(:base, "You cannot book for more than a day.") \
         unless (to.to_i - from.to_i)/1.day < 1
    end

    def validate_timings_respective_to_slot 
        errors.add(:base, "Reservation timings must be in between slot's timing") \
            unless (slot.open_time..slot.close_time).cover?(from_time) && 
                (slot.open_time..slot.close_time).cover?(to_time)
    end

    def validate_from_and_to_time
        errors.add(:base, "Reservation from date time must be before to date time") \
            if to && from && from >= to
    end
end
