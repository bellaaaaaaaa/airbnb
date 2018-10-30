class ListingsController < ApplicationController
    def index
        #show all listings
        @listings = Listing.all
    end

    #Show my listings
    def my_list
        @my_listings = current_user.listings
    end

    def show
        @listing = Listing.find(params[:id])
    end

    def new
    end 

    def edit
        @listing = Listing.find(params[:id])
    end

    def create
        @listing = Listing.new(listing_params)
        @listing.user_id = current_user.id
        @listing.save
        redirect_to @listing
    end

    def update
        @listing = Listing.find(params[:id])
       
        if @listing.update(listing_params)
          redirect_to @listing
        else
          render 'edit'
        end
    end


    def destroy
        @listing = Listing.find(params[:id])
        @listing.destroy
    
        redirect_to my_list_path
    end

    private
    def listing_params
        params.require(:listing).permit(:name, :roomtype, :num_guests, :num_beds, :num_baths, :price_per_night)
    end
end
