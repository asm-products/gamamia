//= require moment

var Comment = React.createClass({
  render: function() {
    var comment = this.props.comment

    return (
      <div className="clearfix relative" id={comment.anchor}>
        <div className="left mr2">
          <User user={comment.user} />
        </div>
        <div className="overflow-hidden">
          <h5 className="mt0 mb0">
            {comment.user.name}
          </h5>
          <p className="light-gray h6">{comment.user.occupation}</p>
          <div className="small light-gray comment-posted">
            {moment(comment.created_at).fromNow()}
          </div>
          {comment.content}

        </div>
      </div>
    )
  }
})

window.Comment = Comment
