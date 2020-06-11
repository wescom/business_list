class CreateBusinessToServicetypes < ActiveRecord::Migration[6.0]
  def self.up
    create_table :businesses_service_types, id: false do |t|
      t.belongs_to :business
      t.belongs_to :service_type
    end
  end

  def self.down
    drop_table :businesses_service_types
  end
end
