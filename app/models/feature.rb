class Feature < ApplicationRecord
    validates :name, presence: true, uniqueness: true

    belongs_to :parking
    has_and_belongs_to_many :slots
end
