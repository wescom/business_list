class CreateZones < ActiveRecord::Migration[6.0]
  def self.up
    create_table :zones do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :zones
  end
end
