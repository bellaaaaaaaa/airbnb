class Listing < ApplicationRecord
  belongs_to :user
  has_many :reservations
  mount_uploader :image, ImageUploader
  mount_uploaders :pictures, ImageUploader

  scope :city, -> (city) { where city: city }
  scope :roomtype, -> (roomtype) {where roomtype: roomtype}
  scope :starts_with, -> (roomtype) { where("roomtype like ?", "#{roomtype}%")}

  # include PgSearch
  # pg_search_scope :search_any_word, 
  #                 :against => [:city, :roomtype],
  #                 :using => {
  #                   :tsearch => {:any_word =>true}
  #                 }
end
