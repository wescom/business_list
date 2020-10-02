class AddRegionIdToBusiness < ActiveRecord::Migration[6.0]
  def self.up
    add_column :businesses, :region_id, :integer
  end

  def self.down
    remove_column :businesses, :region_id, :integer
  end
end
