class ListingsController < ApplicationController
    def index
    end

    def show
        @listing = Listing.find(params[:id])
    end

    def new
    end 

    def create
        @listing = Listing.new(listing_params)
        @listing.user_id = current_user.id
        @listing.save
        redirect_to @listing
    end

    private
    def listing_params
        params.require(:listing).permit(:name, :roomtype, :num_guests, :num_beds, :num_baths, :price_per_night)
    end
end
