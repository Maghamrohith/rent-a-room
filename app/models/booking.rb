class Booking < ActiveRecord::Base
 belongs_to :room
 belongs_to :user
 validates_presence_of :start_date, :end_date


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
   					end
   				end
   			 end

     else
     	
    		self.errors.add(:base, "EndDate should not be less than start_date") 
      end
    end
end
