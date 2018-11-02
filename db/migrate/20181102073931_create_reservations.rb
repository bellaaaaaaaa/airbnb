class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.date :check_in
      t.date :check_out
      t.integer :num_guests
      t.integer :total_price
      t.references :user, foreign_key: true
      t.references :listing, foreign_key: true

      t.timestamps
    end
  end
end
