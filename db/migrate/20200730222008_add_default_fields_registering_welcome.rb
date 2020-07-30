class AddDefaultFieldsRegisteringWelcome < ActiveRecord::Migration[6.0]
  def self.up
    change_table :default_settings do |t|
      t.text :registered_welcome_text
      t.attachment :registered_welcome_image
    end
  end

  def self.down
    remove_column :default_settings, :registered_welcome_text
    remove_attachment :default_settings, :registered_welcome_image
  end
end
