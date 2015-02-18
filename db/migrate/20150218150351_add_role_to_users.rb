class AddRoleToUsers < ActiveRecord::Migration
  def up
    add_column :users, :role, :string
    User.where(is_admin: true).update_all role: "admin"
    remove_column :users, :is_admin
  end

  def down
    add_column :users, :is_admin, :boolean
    User.where(role: "admin").update_all is_admin: true
    remove_column :users, :role
  end
end
