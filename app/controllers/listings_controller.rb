class ListingsController < ApplicationController
    before_action :verify_actions, only:[:verify_listing, :delete]
    before_action :create_actions, only:[:create]
    before_action :modify_actions, only:[:edit, :update, :delete]

    # before_action :do_something, only: [:edit, :update]
    def index
        #show all listings
        @listings = Listing.all.order('name')
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

        if current_user.customer?
            redirect_to my_list_path
        else
            redirect_to listings_path
        end
    end

    private
    def listing_params
        params.require(:listing).permit(:name, :roomtype, :num_guests, :num_beds, :num_baths, :price_per_night, :image)
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
end
