class ReviewsController < ApplicationController
	def index
		@reviews = Review.all
	end
	def create
		@review = Review.new(review_params)
		if @review.save



 private

   def review_params
	 params[:review].permit(:review, :food_rating, :cleanliness_rating, :safety_rating, :facility_rating, :locality_rating, :room_id, :user_id )
    end
end

