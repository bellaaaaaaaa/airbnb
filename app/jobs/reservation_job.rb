class ReservationJob < ApplicationJob
  queue_as :default

  def perform(reservation, host)
    ReservationMailer.successful_reservation(reservation, host).deliver
  end
end
