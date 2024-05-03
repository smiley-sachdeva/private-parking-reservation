class Feature < ApplicationRecord
    belongs_to :parking
    has_and_belongs_to_many :slots

    validates :name, presence: true
    validate :unique_name_within_parking

    private
    def unique_name_within_parking
        if Feature.exists?(name: name, parking_id: parking_id)
          errors.add(:name, "must be unique within the parking")
        end
    end
end
