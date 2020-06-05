class AddRolesToUsers < ActiveRecord::Migration[6.0]
  def self.up
    add_column :users, :admin_role, :boolean, default: false
    add_column :users, :supervisor_role, :boolean, default: false
    add_column :users, :sales_role, :boolean, default: false
    add_column :users, :user_role, :boolean, default: true
  end

  def self.down
    remove_column :users, :admin_role
    remove_column :users, :supervisor_role
    remove_column :users, :sales_role
    remove_column :users, :user_role
  end
end
