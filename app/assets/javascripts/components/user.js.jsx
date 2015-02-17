var User = React.createClass({

  propTypes: {
    user: React.PropTypes.shape({
      name: React.PropTypes.string.isRequired,
      avatar_url: React.PropTypes.string.isRequired
    }).isRequired
  },

  render: function() {
    var user = this.props.user

    return (
      <a className="block" title={user.name}>
        <img className="block" src={user.avatar_url} alt={user.name} width="24" height="24" />
      </a>
    )
  }
})

window.User = User
