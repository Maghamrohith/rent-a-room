class Room < ActiveRecord::Base
	mount_uploader :images, CoverUploader
	has_many :special_prices
	has_many :bookings
	belongs_to :city
	belongs_to :user
	has_many :reviews
	has_many :amenity_rooms
	has_many :amenities, through: :amenity_rooms
	validates_presence_of :name, :description, :price, :address, :rules, :city_id
	validates_length_of :description, within: (1..150)
 
 after_create :change_role
 before_save :search_lat_and_long
  def search_lat_and_long
	 response = HTTParty.get("http://maps.googleapis.com/maps/api/geocode/json?address=#{self.address}")
   		@result = JSON.parse(response.body)
     		self.latitude = @result["results"][0]["geometry"]["location"]["lat"]   
     		self.longitude = @result["results"][0]["geometry"]["location"]["lng"]
     	end
    	def change_role

    	 if self.user.role.name == "guest"
    		self.user.update_attributes(role_id:Role.second.id)
    	end
    end
end



   
	

