module ReactHelper

  def game_component(args)
    game = args.fetch(:game)
    has_current_user_voted_for_game = args.fetch(:has_current_user_voted_for_game)

    react_component(
      'Game',
      {
        game: GameSerializer.new(game),
        hasCurrentUserVotedForGame: has_current_user_voted_for_game
      },
      prerender: true
    )
  end

end
