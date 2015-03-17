class DropIdentityNotNull < ActiveRecord::Migration
  def change
    change_column_null(:identities, :user_id, true)
  end
end
