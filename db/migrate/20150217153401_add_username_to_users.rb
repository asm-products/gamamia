class AddUsernameToUsers < ActiveRecord::Migration
  def up
    add_column :users, :username, :string, null: false, default: ""

    User.all.each do |user|
      user.update_attribute 'username', User.create_username_from(user.name)
    end

    add_index :users, :username, unique: true
  end

  def down
    remove_column :users, :username
  end
end
