class CreateDefaultSettingsEmails < ActiveRecord::Migration[6.0]
  def self.up
    create_table :default_settings_emails do |t|
      t.string :name
      t.string :description
      t.string :email_from_address
      t.string :email_subject
      t.text :email_pretext
      t.text :email_posttext
      t.boolean :show_contact_info, :default => true
      t.boolean :show_business_info, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :default_settings_emails
  end
end
