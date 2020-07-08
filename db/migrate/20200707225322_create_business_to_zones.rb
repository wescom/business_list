class CreateBusinessToZones < ActiveRecord::Migration[6.0]
  def self.up
    create_table :businesses_zones, id: false do |t|
      t.belongs_to :business
      t.belongs_to :zone
    end
  end

  def self.down
    drop_table :businesses_szones
  end
end
