class NotNullConstraints < ActiveRecord::Migration
  def change
    change_column_null(:comments, :content, false)
    change_column_null(:comments, :user_id, false)
    change_column_null(:comments, :game_id, false)
    change_column_null(:games, :title, false)
    change_column_null(:games, :link, false)
    change_column_null(:identities, :user_id, false)
    change_column_null(:videos, :game_id, false)
    change_column_null(:videos, :embed, false)
  end
end
