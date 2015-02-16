class MigratePlatformToTags < ActiveRecord::Migration
  def up
    Game.all.each do |game|
      game.update_attributes platform_list: [game.platform]
    end
    remove_column :games, :platform
  end

  def down
    add_column :games, :platform, :string
    Game.all.each do |game|
      game.update_attributes platform: game.platform_list.first
    end
  end
end
