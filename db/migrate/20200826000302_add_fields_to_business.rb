class AddFieldsToBusiness < ActiveRecord::Migration[6.0]
  def self.up
    add_column :businesses, :lat, :decimal, {:precision=>10, :scale=>6}
    add_column :businesses, :lng, :decimal, {:precision=>10, :scale=>6}

    add_column :businesses, :pause_listing, :boolean
    add_column :businesses, :food_truck, :boolean
  end

  def self.down
    remove_column :businesses, :lat
    remove_column :businesses, :lng
    remove_column :businesses, :pause_listing
    remove_column :businesses, :food_truck
  end
end
