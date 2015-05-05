class CreateGamePlatforms < ActiveRecord::Migration
  def change
    create_table :game_platforms do |t|
      t.references :game, index: true
      t.references :platform, index: true
      t.string :url

      t.timestamps null: false
      t.index [:game_id, :platform_id], unique: true
    end
    add_foreign_key :game_platforms, :games
    add_foreign_key :game_platforms, :platforms
  end
end
