var Upvote = React.createClass({

  propTypes: {
    game: React.PropTypes.shape({
      votes_up: React.PropTypes.number.isRequired
    }),
    hasCurrentUserVotedForGame: React.PropTypes.bool.isRequired
  },

  render: function() {
    var game = this.props.game

    if (this.props.hasCurrentUserVotedForGame) {
      return (
        <a className="upvote-block -voted block px2 py1" href={game.url + '/unupvote'} data-method="post">
          <p className="voteicon">▲</p>
          <p className="m0">{game.votes_up}</p>
        </a>
      )
    } else {
      return (
        <a className="upvote-block block px2 py1 light-gray" href={game.url + '/upvote'} data-method="post">
          <p className="voteicon">▲</p>
          <p className="m0">{game.votes_up}</p>
        </a>
      )
    }
  }
})

window.Upvote = Upvote
