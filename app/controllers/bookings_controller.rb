class BookingsController < ApplicationController
	def index
		@bookings = current_user.bookings
    end

    def create
    	@booking = Booking.new(booking_params)
    	@booking.user_id = current_user.id
    	@booking.save
        if @booking.errors[:base].empty?
		  redirect_to bookings_path, notice: "booking is created"
	    else
		  redirect_to room_path(@booking.room_id), notice:"#{@booking.errors[:base]}"
        end			
    end

    def update
        @booking = Booking.find(params[:id])
        if @booking.update_attributes(booking_params)
            redirect_to bookings_path, notice: "successfully updated booking"
        end
    end

    def unconfirmed
        if current_user.role("host")
            @bookings = Booking.where("is_confirmed =?", false).all
        end
    end


    private
    def booking_params

    params[:booking].permit(:start_date, :end_date, :is_confirmed, :user_id, :room_id)	
    end	
end

