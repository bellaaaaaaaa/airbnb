class RemoveTypeFromListings < ActiveRecord::Migration[5.2]
  def change
    remove_column :listings, :type, :string
  end
end
