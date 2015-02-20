var Upvote = {
	config : {
		voteLink: $('.js-vote'),
		voted: ''
	},

	init : function(config) {
		this.bindUIActions();
	},

	bindUIActions : function() {
		Upvote.config.voteLink.on('click', Upvote.handleVoteState);
	},

	handleVoteState: function(e) {
		e.preventDefault();
		e.stopPropagation();
		Upvote.config.voteLink = $(this);

		Upvote.config.voted = Upvote.config.voteLink.data('voted');
		if(Upvote.config.voted) {
			Upvote.config.url = Upvote.config.voteLink.attr('href') + '/unupvote'; 
		} else {
			Upvote.config.url = Upvote.config.voteLink.attr('href') + '/upvote';
		}
		

		Upvote.postVotes();
		Upvote.handleVoteText();
	},

	postVotes: function() {
		$.ajax({
			url: Upvote.config.url,
			type: 'POST',
			error: function(xhr, status, err) {
				Upvote.handleError();
			}
		})
	},

	handleVoteText: function() {
		votes = Upvote.config.voteLink.find('.votetext');

		if(Upvote.config.voted) {
			Upvote.config.voteLink.removeClass('-voted');
			votes.html(parseInt(votes.html()) - 1);
			Upvote.config.voteLink.data('voted', false);
		} else {
			Upvote.config.voteLink.addClass('-voted');
			votes.html(parseInt(votes.html()) + 1);
			Upvote.config.voteLink.data('voted', true);
		}
	},

	handleError: function() {
		if(Upvote.config.voted) {
			Upvote.config.voteLink.addClass('-voted');
			votes.html(parseInt(votes.html()) + 1);
			Upvote.config.voteLink.data('voted', true);
		} else {
			Upvote.config.voteLink.removeClass('-voted');
			votes.html(parseInt(votes.html()) - 1);
			Upvote.config.voteLink.data('voted', false);
		}
	}
}