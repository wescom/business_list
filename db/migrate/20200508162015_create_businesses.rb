class CreateBusinesses < ActiveRecord::Migration[6.0]
    def self.up
      create_table :businesses do |t|
        t.string :name
        t.integer :business_type_id
        t.string :hours
        t.string :website
        t.string :address1
        t.string :address2
        t.string :city
        t.string :state
        t.string :zipcode
        t.string :phonenum
        t.string :email
        t.text :notes
        t.timestamps
      end
    end

    def self.down
      drop_table :businesses
    end
end
