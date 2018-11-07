class ReservationsController < ApplicationController
    def create
        @listing = Listing.find(params[:listing_id])
        @reservation = Reservation.new(reservation_params)
        @reservation.user_id = current_user.id
        @reservation.listing_id = @listing.id
        @reservation.total_price = (@reservation.check_out - @reservation.check_in) * @listing.price_per_night

        if !@reservation.is_available?
            redirect_to @listing, notice: "Sorry this listing is already booked on those dates, please select different checkin/out dates."
        else
            if @reservation.save
                redirect_to braintree_new_path(:id => @reservation.id), notice: "Booked!"
            else
                redirect_to @listing, notice: @reservation.errors.full_messages 
            end
        end
            
    end

    private 
    def reservation_params
        params.require(:reservation).permit(:check_in, :check_out, :num_guests)
    end
end
