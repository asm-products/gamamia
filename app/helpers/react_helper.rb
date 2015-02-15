module ReactHelper

  RENDER_OPTS = {
    prerender: false
  }

  def game_component(props)
    game = props.fetch(:game)
    has_current_user_voted_for_game = props.fetch(:has_current_user_voted_for_game)

    react_component(
      'Game',
      {
        game: GameSerializer.new(game),
        hasCurrentUserVotedForGame: has_current_user_voted_for_game
      },
      RENDER_OPTS
    )
  end

  def comment_component(props)
    comment = props.fetch(:comment)

    react_component(
      'Comment',
      {
        comment: CommentSerializer.new(comment)
      },
      RENDER_OPTS
    )
  end

end
