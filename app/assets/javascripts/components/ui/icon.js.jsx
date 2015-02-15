var Icon = React.createClass({
  propTypes: {
    icon: React.PropTypes.string.isRequired
  },

  render: function() {
    return <span className={"fa fa-" + this.props.icon} />
  }
})

window.Icon = Icon
