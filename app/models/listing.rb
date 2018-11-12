class Listing < ApplicationRecord
  paginates_per 20
  belongs_to :user
  has_many :reservations, dependent: :destroy
  mount_uploader :image, ImageUploader
  mount_uploaders :pictures, ImageUploader

  def self.search_city(query)
    where("city ILIKE :city", city: "%#{query}%").map do |record|
      record.city 
    end
  end

  scope :city, -> (city) { where city: city }
  scope :roomtype, -> (roomtype) {where roomtype: roomtype}
  scope :starts_with, -> (roomtype) { where("roomtype like ?", "#{roomtype}%")}

end
