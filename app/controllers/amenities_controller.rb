class AmenitiesController < ApplicationController
	before_action :set_amenity, only: [:show, :edit, :update, :destroy]
	def index
		@amenities = Amenity.all
	end
	def new
		@amenity = Amenity.new
    end
    def create
    	@amenity = Amenity.new(amenity_params)
    	if @amenity.save
    		redirect_to amenities_path, notice: "successfully added amenity"
    	else
    		render :new
    	end
    end

    def show
    end
    def  edit
    end

    def update
			if @amenity.update_attributes(room_params)
				redirect_to amenity_path(@amenity.id), notice: "successfully Updated the amenity"
			else
				render action: "edit"
			end
		end
		def destroy
			@amenity = Amenity.find(params[:id])
			@amenity.destroy
			redirect_to amenities_path, notice: "successfully destroyed the amenity"
		end

 def set_amenity
	@amenity = Amenity.find(params[:id])
 end

 def amenity_params
	params[:amenity].permit(:name, :description)
 end
end

