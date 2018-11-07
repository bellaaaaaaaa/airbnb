class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  validate :check_in_out_dates, :check_in_out_dates_against_current_date
  
  def is_available?
    current_reservation_dates = [self.check_in, self.check_out] # Check in/out dates chosed by user for listing
    current_listing_reservations = self.listing.reservations # All reservations for current listing
    current_listing_dates =[]

    # Stores just the check_in/out dates for the current listing into current_listing_dates
    current_listing_reservations.each do |i|
      temporary = (i.check_in..i.check_out).to_a
      temporary.each do |z|
        current_listing_dates << z
      end
    end

    # Checks for overlap of dates between dates chosen by user and already existing reservations.
    both =[current_reservation_dates, current_listing_dates]
    both.inject(:&)
    if both.inject(:&).length != 0
      false
    else
      true
    end
  end

  def overlaps_existing_reservation?
  end

  private

  # Makes sure check out date comes after check in date
  def check_in_out_dates
    if self.check_out < self.check_in
      errors.add(:check_in_or_check_out_dates, "check out date can't be before check in date.")
    end
  end

  # Listings must be booked after the current date
  def check_in_out_dates_against_current_date
    if self.check_in < Date.current || self.check_out < Date.current
      errors.add(:chose_dates_must_be_in_future, "dates must be set after today")
    end
  end
end








