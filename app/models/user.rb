class User < ApplicationRecord
  has_many :authentications, dependent: :destroy
  has_many :listings 
  has_many :reservations
  mount_uploader :image, ImageUploader
  include Clearance::User
  # Declaring roles for user
  enum status: { superadmin: 0, moderator: 1, customer: 2 }
 
  def self.create_with_auth_and_hash(authentication, auth_hash)
    user = self.create!(
      fullname: auth_hash["info"]["name"],
      email: auth_hash["info"]["email"],
      password: SecureRandom.hex(10)
    )
    user.authentications << authentication # stores token for future use
    return user
  end
 
  # grab google to access google for user data
  def google_token
    x = self.authentications.find_by(provider: 'google_oauth2')
    return x.token unless x.nil?
  end
 end
