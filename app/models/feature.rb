class Feature < ApplicationRecord
    validates :name, presence: true, uniqueness: true

    belongs_to :parking
end
