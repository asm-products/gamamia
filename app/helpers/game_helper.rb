module GameHelper
  def game_platforms_list(game)
    game.platforms.map(&:name).join(", ")
  end
end
