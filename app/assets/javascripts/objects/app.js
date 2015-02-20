var App = {
	el : {
		gameLink: $('.js-game')
	},

	init: function() {
		this.bindUIActions();
	},

	bindUIActions: function() {
		App.el.gameLink.on('click', App.handleGameState)
	},

	handleGameState: function() {
		var link = $(this).find('a').first().attr('href');
		window.location = link;
	}
}