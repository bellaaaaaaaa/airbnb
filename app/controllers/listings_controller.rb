class ListingsController < ApplicationController
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
        if current_user.customer?
            flash[:notice] = "Sorry. You are not allowed to perform this action."
            return redirect_to root_url, notice: "Sorry. You do not have the permission to verify a property."
  
            elsif current_user.moderator?
                @listing.update(verified: true)
                return redirect_to listings_path, notice: "Listing Verified!"

              
            elsif current_user.superadmin?
                @listing.update(verified: true)
                return redirect_to listings_path, notice: "Listing Verified!"
          end
    end

    def allowed?(action:, user:)
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

    # def do_something
    #     redirect_to root_url
    # end
end
