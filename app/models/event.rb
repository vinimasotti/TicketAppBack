class Event < ApplicationRecord
    #inherited class from application record

    before_save :adjust_price
    has_many :comments, dependent: :destroy 
    #relationship between events and comments

    def adjust_price #ensuring pricing is updated dinamycally 
      if remaining_tickets.present? && remaining_tickets <= (total_tickets * 0.1)
        self.price *= 1.10 # Increase price by 10%
      end
    end
  
    def buy_ticket #logic for purchasing tickets
      if remaining_tickets > 0
        self.remaining_tickets -= 1
        save!
      else
        raise "No tickets available"
      end
    end
  end