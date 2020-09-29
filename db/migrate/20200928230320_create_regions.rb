class CreateRegions < ActiveRecord::Migration[6.0]
  def self.up
    create_table :regions do |t|
      t.integer :zone_id
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :regions
  end
end
