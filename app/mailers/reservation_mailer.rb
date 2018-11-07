# Mailer Controller
class ReservationMailer < ApplicationMailer
    default from: 'airbnbclone@example.com'

    def successful_reservation(reservation, host)
        @user = reservation.user
        # @reservation = reservation
        mail(to: host.email, subject: 'Someone booked your listing!')
    end
end

