class ForeignKeys < ActiveRecord::Migration
  def change
    add_foreign_key :comments, :users, name: :comments_user_id_fk
    add_foreign_key :comments, :games, name: :comments_game_id_fk
    add_foreign_key :games, :users, name: :games_user_id_fk
    add_foreign_key :identities, :users, name: :identities_user_id_fk
    add_foreign_key :videos, :games, name: :videos_game_id_fk
  end
end
