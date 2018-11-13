require 'faker'

# Seed Users
user = {}
user['password'] = 'asdf'

ActiveRecord::Base.transaction do
  5.times do 
    user['fullname'] = Faker::Name.first_name 
    user['email'] = Faker::Internet.email
    user['age'] = rand(18..60)
    User.create(user)
  end
end 

# Seed Listings
listing = {}
uids = []
User.all.each { |u| uids << u.id }

ActiveRecord::Base.transaction do
  20.times do 
    listing['name'] = Faker::App.name
    listing['roomtype'] = ["House", "Entire Floor", "Condominium", "Villa", "Townhouse", "Castle", "Treehouse", "Igloo", "Yurt", "Cave", "Chalet", "Hut", "Tent", "Other"].sample
    listing['city'] = ["Tokyo", "Singapore", "Paris", "New York", "Athens", "Rome", "Venice", "Shanghai", "Kyoto", "Bangkok", "Hong Kong", "Bali"].sample

    listing['num_guests'] = rand(1..5)
    listing['num_beds'] = rand(1..6)
    listing['num_baths'] = rand(1..7)
    listing['price_per_night'] = rand(80..500)
    listing['user_id'] = uids.sample
    Listing.create(listing)
  end
end