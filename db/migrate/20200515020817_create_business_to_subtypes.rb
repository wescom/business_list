class CreateBusinessToSubtypes < ActiveRecord::Migration[6.0]
  def self.up
    create_table :business_subtypes_businesses, id: false do |t|
      t.belongs_to :business
      t.belongs_to :business_subtype
    end
  end

  def self.down
    drop_table :business_subtypes_businesses
  end
end
