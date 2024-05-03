class Feature < ApplicationRecord
    belongs_to :parking
    has_and_belongs_to_many :slots

    validates :name, 
        presence: true, 
        uniqueness: { scope: :parking_id, message: "must be unique within the parking" }

end
