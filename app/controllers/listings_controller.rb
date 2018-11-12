class ListingsController < ApplicationController
    before_action :verify_actions, only:[:verify_listing, :delete]
    before_action :create_actions, only:[:create]
    before_action :modify_actions, only:[:edit, :update, :delete]

    # before_action :do_something, only: [:edit, :update]
    def index
        @listings = Listing.order(:name).page params[:page]
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

    def verify_listing
        @listing = Listing.find(params[:id])
        @listing.update(verified: true)
        return redirect_to listings_path, notice: "Listing Verified!"
    end
    def unverify_listing
        @listing = Listing.find(params[:id])
        @listing.update(verified: false)
        return redirect_to listings_path, notice: "Listing Unverified!"
    end

    def edit
        @listing = Listing.find(params[:id])
    end

    def create
        @listing = Listing.new(listing_params)
        @listing.user_id = current_user.id
        @listing.city = ["Tokyo", "Singapore", "Paris", "New York", "Athens", "Rome", "Venice", "Shanghai", "Kyoto", "Bangkok", "Hong Kong", "Bali"].sample
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

        if current_user.customer?
            redirect_to my_list_path
        else
            redirect_to listings_path
        end
    end

    def search
        @listings_autocomplete = Listing.search_city(params["search"]) #added
        @listings = Listing.city(params[:search])
        @listings += Listing.roomtype(params[:search])
        respond_to do |format|
            format.html { render 'index' } # local: true
            format.json { render json: @listings_autocomplete }
            format.js # remote: true
        end
    end

    ########################################## ACTIONS FOR NUMBER OF ROOMS! ##########################################
    def one_room
        @listings = Listing.where(num_beds: 1)
        render 'index'
    end
    def two_rooms
        @listings = Listing.where(num_beds: 2)
        render 'index'
    end
    def three_rooms
        @listings = Listing.where(num_beds: 3)
        render 'index'
    end
    def four_rooms
        @listings = Listing.where(num_beds: 4)
        render 'index'
    end
    def five_rooms
        @listings = Listing.where("num_beds >= ?", 5)
        render 'index'
    end

    private
    def listing_params
        params.require(:listing).permit(:name, :roomtype, :num_guests, :num_beds, :num_baths, :price_per_night, :image, {pictures:[]}, :city)
    end

    # Moderator and Superadmin can verify and delete listings
    def verify_actions
        @listing = Listing.find(params[:id])
        if current_user.customer? && @listing.user_id != current_user.id 
            redirect_to root_url, notice: "You cant do this"
        end 
    end

    # Only customers can create listings
    def create_actions
        if !current_user.customer?
            redirect_to root_url, notice: "You cant do this"
        end
    end

    # If listing doesn't belong to current user- he cannot edit, update or delete
    def modify_actions
        @listing = Listing.find(params[:id])
        if current_user.id != @listing.user_id
            redirect_to root_url, notice: "You cant do this"
        end
    end

    def filtering_params(params)
        params.slice(:city, :starts_with)
    end
end
