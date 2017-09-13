class RoomsController < ApplicationController
	before_action :set_room, only: [:show, :edit, :update, :destroy]
	def index
		@rooms = Room.all
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
	end
	def edit
	end
	def update
			if @room.update_attributes(room_params)
				redirect_to room_path(@room.id), notice: "successfully Updated the city"
			else
				render action: "edit"
			end
		end
		def destroy
			@room = Room.find(params[:id])
			@room.destroy
			redirect_to rooms_path, notice: "successfully destroyed the room"
		end
	private
	def set_room
		@room = Room.find(params[:id])
	end

	def room_params
		params[:room].permit(:name, :description, :price, :rules, :address, :images, :longitude, :latitude, :city_id, :user_id, amenity_ids:[])
    end
end

