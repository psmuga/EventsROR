class Event < ApplicationRecord
    validates :artist, :presence => true
    validates :price_low, :presence => true, numericality: true
    validates :price_high, :presence => true, numericality: true
    validates :event_date, :presence => true
    validate :event_date_not_from_past, :price_high_not_lower_than_price_low

    has_many :tickets
    
    def event_date_not_from_past
        if event_date < Date.today
            errors.add('Data wydarzenia', 'nie może być z przeszłości')
        end 
    end
    def price_high_not_lower_than_price_low
        if price_high < price_low
            errors.add('Price high', "can't be lower than Price low")
        end
    end
end
