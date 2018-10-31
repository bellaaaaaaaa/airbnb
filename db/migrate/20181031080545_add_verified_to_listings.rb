class AddVerifiedToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :verified, :boolean
  end
end
