class ReservationsController < ApplicationController
    def create
        @listing = Listing.find(params[:listing_id])
        @reservation = Reservation.new(reservation_params)
        @reservation.user_id = current_user.id
        @reservation.listing_id = @listing.id
        @reservation.save
        redirect_to root_url
    end

    private 
    def reservation_params
        params.require(:reservation).permit(:check_in, :check_out, :num_guests)
    end
end
