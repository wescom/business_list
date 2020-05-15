class CreateBusinessSubtypes < ActiveRecord::Migration[6.0]
  def self.up
    create_table :business_subtypes do |t|
      t.integer :business_type_id
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :business_subtypes
  end
end
