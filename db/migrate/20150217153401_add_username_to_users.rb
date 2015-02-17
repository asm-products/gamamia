class AddUsernameToUsers < ActiveRecord::Migration
  def up
    add_column :users, :username, :string, null: false, default: ""

    User.all.each do |user|
      username = n = ""
      loop do
        username = user.name.parameterize + n.to_s
        n = n.to_i + 1
        break unless User.exists?(username: username)
      end
      user.update_attributes! username: username
    end

    add_index :users, :username, unique: true
  end

  def down
    remove_column :users, :username
  end
end
