class Event < ApplicationRecord
    validates :start_date, :duration, :title, :description, :price, :location, presence: true
    validates :start_date, comparison: { greater_than: Time.new }
    validates :duration, :check_duration
    validates :title, length: {minimum:5, maximum:140}
    validates :description, length: {minimum:20, maximum:1000}
    validates :price, :right_price

    has_many :participations
    has_many :participants, class_name: "User", through: :participations
    belongs_to :admin, class_name: "User"

    def check_duration
        unless self.duration % 5 == 0
            errors.add(:duration, "must be multiple of 5")
        end
        unless self.duration > 0
            errors.add(:duration, "must be greater than 0")
        end
    end
    def right_price
        unless self.price >= 0
            errors.add(:price, "must be between 1 and 1000")
        end
        unless  && self.price <= 1000
            errors.add(:price, "must be between 1 and 1000")
        end
    end
end
