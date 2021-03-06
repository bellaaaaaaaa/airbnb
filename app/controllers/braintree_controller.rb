class BraintreeController < ApplicationController
  def new
    @reservation = Reservation.find(params[:id])
    @client_token = Braintree::ClientToken.generate
  end

  def checkout
    @reservation = Reservation.find(params[:id])
    nonce_from_the_client = params[:checkout_form][:payment_method_nonce]
  
    result = Braintree::Transaction.sale(
     :amount => @reservation.total_price,
     :payment_method_nonce => nonce_from_the_client,
     :options => {
        :submit_for_settlement => true
      }
     )
  
    if result.success?
      # ReservationMailer.successful_reservation(@reservation, @reservation.listing.user).deliver_now
      ReservationJob.perform_later(@reservation, @reservation.listing.user)
      redirect_to :root, :flash => { :success => "Transaction successful!" }
    else
      redirect_to :root, :flash => { :error => "Transaction failed. Please try again." }
    end
  end
end
