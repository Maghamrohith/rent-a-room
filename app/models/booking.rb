class Booking < ActiveRecord::Base
 belongs_to :room
 belongs_to :user
 validates_presence_of :start_date, :end_date
 validate :check_total, on: :create

 validate :check_startdate_end_date, on: :create

  def check_startdate_end_date
   if self.start_date <= self.end_date       	
 	    current_booking = (self.start_date..self.end_date).to_a
 	    bookings = Booking.where('room_id = ?',self.room_id)
 	    bookings.each do |booking|
 		    future_bookings = (booking.start_date..booking.end_date).to_a
 		    current_booking.each do |booking|
 				  if future_bookings.include?booking 
 					  self.errors.add(:base,"Already booked")
 					  break
 				  end
 			  end
      end
    else
  		self.errors.add(:base, "EndDate should not be less than start_date") 
    end
  end

  def check_total
    if room.special_prices.any?
      intial_date= self.start_date
      final_date= self.end_date
      booked_dates = (intial_date..final_date).to_a
      offer_dates =  SpecialPrice.where('room_id = ?',self.room_id)
      offer_dates.each do |offer_date|
        date1 = offer_date.start_date
        date2 = offer_date.end_date
        offer_days = (date1..date2).to_a
        booked_dates.each do |date|
          if offer_days.include?(date)
            self.price = self.price.to_i + offer_date.price
          else
            self.price = self.price.to_i + self.room.price
          end
        end
      end
    else
      date1 = self.start_date
      date2 = self.end_date
      total_days = (date1..date2).to_a
      self.price = total_days.length * self.room.price
    end
  end
end
