class Event < ApplicationRecord
    before_validation :right_price, :must_be_futur, :right_duration
    validates :location, presence: true
    validates :start_date, presence: true
    validates :duration, presence: true
    validates :title, length: {minimum:5, maximum:140}, presence: true
    validates :description, length: {minimum:20, maximum:1000}, presence: true
    validates :price, presence: true

    has_many :participations
    has_many :participants, class_name: "User", through: :participations
    belongs_to :admin, class_name: "User"

    def right_duration
        if self.duration % 5 != 0
            errors.add(:duration, "must be multiple of 5")
        end
        if self.duration < 0
            errors.add(:duration, "must be greater than 0")
        end
    end
    def right_price
        if self.price <= 0
            errors.add(:price, "must be between 1 and 1000")
        end
        if self.price > 1000
            errors.add(:price, "must be between 1 and 1000")
        end
    end
    def must_be_futur 
        if self.start_date < Time.now
            errors.add(:start_date, "must be in future")
        end
    end
end
