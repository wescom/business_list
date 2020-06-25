class CreateDefaultSettings < ActiveRecord::Migration[6.0]
  def self.up
    create_table :default_settings do |t|
      t.attachment :homepage_banner_image
      t.text    :home_welcome_text
      t.text    :general_instructions
      t.text    :registration_text

      t.string  :confirmation_from_email
      t.string  :contact_email

      t.timestamps
    end
  end

  def self.down
    drop_table :default_settings
  end
end
