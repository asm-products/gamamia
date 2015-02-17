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

  def show_component(props)
    game = props.fetch(:game)
    has_current_user_voted_for_game = props.fetch(:has_current_user_voted_for_game)

    react_component(
      'Show',
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

  def upvote_component(props)
    game = props.fetch(:game)

    react_component(
      'Upvote',
      {
        game: GameSerializer.new(game),
        hasCurrentUserVotedForGame: signed_in? && current_user.voted_for?(game)
      },
      RENDER_OPTS
    )
  end

  def avatar(attrs={})
    user = attrs.fetch(:user)

    react_component(
      'User',
      {
        user: UserSerializer.new(user)
      }, RENDER_OPTS
    )
  end

  def icon(icon)
    react_component 'Icon', icon: icon
  end

end
