var User = React.createClass({

  propTypes: {
    user: React.PropTypes.shape({
      name: React.PropTypes.string
    })
  },

  render: function() {
    var user = this.props.user

    return (
      <a className="block" title={user.name}>
        <img className="block circle" src="https://gravatar.com/avatar/08f077ea061585744ee080824f5a8e65.png?s=48&d=monsterid" alt={user.name} width="24" height="24" />
      </a>
    )
  }
})

window.User = User
