class RoomsController < ApplicationController
	load_and_authorize_resource 
	before_action :set_room, only: [:show, :edit, :update, :destroy]
	def index
		@rooms = Room.where("is_authorized=?", true)
	end
	def new
		@room = Room.new
	end
	def create
		@room = Room.new(room_params)
		@room.user_id = current_user.id
		if @room.save

			redirect_to rooms_path
		else
			render :new
		end
	end
	def show
		@booking = Booking.new
	end
	def edit
	end
	def update
			 if @room.update_attributes(room_params)
			 	 Notification.room_conformation(@room).deliver!
			  redirect_to room_path(@room.id), notice: "successfully Updated the room"
			else
				render action: "edit"
				
			end
		end
		def destroy
			@room.destroy
			redirect_to rooms_path, notice: "successfully destroyed the room"
		end
		def unauthorize
			@room = Room.where('is_authorized = ?', false)
		end
		def myrooms
			@rooms = current_user.rooms
		end


	private
	def set_room
		@room = Room.find(params[:id])
	end

	def room_params
		params[:room].permit(:name, :description, :price, :rules, :address, :images, :longitude, :latitude, :is_authorized, :city_id, :user_id, amenity_ids:[])
    end
end

