class AddMoreFieldsToBusinesses < ActiveRecord::Migration[6.0]
  def self.up
    add_column :businesses, :yelp_url, :string
    add_column :businesses, :happy_hour, :boolean

    add_reference :businesses, :owner, references: :users, index: true
    add_foreign_key :businesses, :users, column: :owner_id

    add_column :businesses, :status, :string, :default => "business_info"
    add_column :businesses, :approved, :boolean
  end

  def self.down
    remove_column :businesses, :owner_id
    remove_column :businesses, :yelp_url
    remove_column :businesses, :happy_hour
    remove_column :businesses, :status
    remove_column :businesses, :approved
  end
end
