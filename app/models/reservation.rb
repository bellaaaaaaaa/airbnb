class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  # validate :no_reservation_overlap

#   def confirm_available
#     # Check if dates overlap
#       # If they do, add an error message
#       # self => reservation being checked right now
#         reservations = self.listing.reservations # resturns a list of reservations
#         for reservation in reservations do        
#   end

# end
end
# scope :overlapping, ->(period_start, period_end) do
#    where "((check_in <= ?) and (check_out >= ?))", period_end, period_start
# end

# private

# def no_reservation_overlap
#  if (Reservation.overlapping(check_in, check_out).any?)
#     errors.add(:date_end, 'Your reservation overlaps another one. Please choose a different check in/out date.')
#  end
# end

# reservations.each do |reservation|
#   reservation.check_in
# end