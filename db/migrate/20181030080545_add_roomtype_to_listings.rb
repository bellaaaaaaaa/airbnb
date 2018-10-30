class AddRoomtypeToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :roomtype, :string
  end
end
