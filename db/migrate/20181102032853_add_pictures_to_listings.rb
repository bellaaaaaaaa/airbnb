class AddPicturesToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :pictures, :json
  end
end
