//= require lib/truncate

var Game = React.createClass({

  propTypes: {
    game: React.PropTypes.object.isRequired,
    hasCurrentUserVotedForGame: React.PropTypes.bool.isRequired
  },

  render: function() {
    var game = this.props.game

    var thumbnail =
      <div className="bg-mid-gray col col-8" style={{
          backgroundImage: 'url(' + game.thumbnail + ')',
          backgroundSize: 'cover',
          backgroundPosition: 'center',
          height: '12em'
        }} />

    return (
      <div className="table" onClick={this.handleClick}>
        <div className="col-1 table-cell">
          <Upvote game={game}
            hasCurrentUserVotedForGame={this.props.hasCurrentUserVotedForGame} />
        </div>
        <div className="rounded bg-white relative table-cell col-12 clearfix">

          <div className="col col-4 p2">
            <h4 className="mt0">
              <a className="dark-gray" href={game.link}>{game.title}</a>
            </h4>

            <p className="mb0 light-gray gamecaption">{truncate(game.description, 100)}</p>
            <footer className="clearfix mt3 game-meta">
              <p className="left mb0">{game.platform_list}</p>
              <div className="right light-gray mb0 comments">
                <Icon icon="comment" /> {game.comments_count}
              </div>
            </footer>
          </div>

          {thumbnail}
        </div>
      </div>
    )
  },

  handleClick: function(e) {
    if ($(e.target).parents('a').length === 0) {
      window.location = this.props.game.url
    }
  }
})

window.Game = Game
