class Ticket < ApplicationRecord
    validates :name, :presence => true, :length => { :minimum => 6 }
    validates :email_address, :presence => true, uniqueness: true
    validates :price, :presence => true, numericality: true
    validates :seat_id_seq, :presence => true, uniqueness: true
    validates :address, :presence => true
    validates :phone, :presence => true
    validate :price_should_be_in_range, :limited_places

    belongs_to :event
    belongs_to :user

    def price_should_be_in_range
        if price < (Event.find_by id: event_id).price_low
            a = (Event.find_by id: event_id).price_low
            b = (Event.find_by id: event_id).price_high
            errors.add('Cena', "musi być w przedziale #{a} - #{b}")
        end 
    end

    def limited_places
        if Ticket.all.length >=  100
            errors.add('Brak', "miejsc")
        end
    end

end
