class Parking < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    validates :open_time, presence: true
    validates :close_time, presence: true

    validate :open_time_before_close_time

    has_many :features

    private
    def open_time_before_close_time
        errors.add(:base, "Opening time must be before closing time") if open_time > close_time
    end
end
