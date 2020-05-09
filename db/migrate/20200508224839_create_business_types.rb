class CreateBusinessTypes < ActiveRecord::Migration[6.0]
    def self.up
      create_table :business_types do |t|
        t.string :type
        t.timestamps
      end
    end

    def self.down
      drop_table :business_types
    end
end
