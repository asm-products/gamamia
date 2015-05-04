class AddGameDevelopersTable < ActiveRecord::Migration
  def change
    create_table :game_developers do |t|
      t.string :thumbnail
      t.string :location
      t.string :title

      t.timestamps
    end

    add_column :games, :game_developer_id, :integer
    add_index :games, :game_developer_id
    add_foreign_key :games, :game_developers, name: "games_game_developer_id_fk"
  end
end
