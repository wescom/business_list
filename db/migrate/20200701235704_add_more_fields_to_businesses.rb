class AddMoreFieldsToBusinesses < ActiveRecord::Migration[6.0]
  def self.up
    add_column :businesses, :owner_id, :integer
    add_column :businesses, :yelp_url, :string
    add_column :businesses, :business_listing_zone, :string
    add_column :businesses, :happy_hour, :boolean
    add_column :businesses, :award_id, :integer
  end

  def self.down
    remove_column :businesses, :owner_id
    remove_column :businesses, :yelp_url
    remove_column :businesses, :business_listing_zone
    remove_column :businesses, :happy_hour
    remove_column :businesses, :award_id
  end
end
