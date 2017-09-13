class CitiesController < ApplicationController
	load_and_authorize_resource
	def index
		@cities = City.all
	end
	def new
		@city = City.new
	end

	def create
		@city = City.new(city_params)
		if @city.save
			redirect_to cities_path, notice: "successfully added City"
		else
			render :new
		end
	end
		def show
			@city = City.find(params[:id])
		end
		def edit
			@city = City.find(params[:id])
		end
		def update
			if @city.update_attributes(city_params)
				redirect_to city_path(@city.id), notice: "successfully Updated the city"
			else
				render action: "edit"
			end
		end
		def destroy
			@city = City.find(params[:id])
			@city.destroy
			redirect_to cities_path, notice: "successfully destroyed the room"
		end


	 private
	  def city_params
		params[:city].permit(:name)
	   end

end



