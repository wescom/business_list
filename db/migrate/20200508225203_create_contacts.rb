class CreateContacts < ActiveRecord::Migration[6.0]
    def self.up
      create_table :contacts do |t|
        t.integer :business_id
        t.string :name
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
      drop_table :contacts
    end
end
