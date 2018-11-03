class ReservationsController < ApplicationController
    def create
        @listing = Listing.find(params[:listing_id])
        @reservation = Reservation.new(reservation_params)
        @reservation.user_id = current_user.id
        @reservation.listing_id = @listing.id

        current_reservation_dates = [@reservation.check_in, @reservation.check_out] # Check in/out dates chosed by user for listing
        current_listing_reservations = @reservation.listing.reservations # All reservations for current listing
        current_listing_dates =[]

        # Stores just the check_in/out dates for the current listing into current_listing_dates
        current_listing_reservations.each do |i|
            current_listing_dates << i.check_in
            current_listing_dates << i.check_out
        end

        # Checks for overlap of dates between dates chosen by user and already existing reservations.
        both =[current_reservation_dates, current_listing_dates]
        both.inject(:&)
        if both.inject(:&).length != 0
            redirect_to root_url, notice: "Sorry this listing is already booked on those dates, please select different checkin/out dates."
        else
            @reservation.save
            redirect_to root_url
        end
            
    end

    private 
    def reservation_params
        params.require(:reservation).permit(:check_in, :check_out, :num_guests)
    end
end
