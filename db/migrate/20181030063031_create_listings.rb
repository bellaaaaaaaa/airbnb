class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :name
      t.string :type
      t.integer :num_guests
      t.integer :num_beds
      t.integer :num_baths
      t.integer :price_per_night
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
