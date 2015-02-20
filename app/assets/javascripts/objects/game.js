var Game = {
	config : {
		gameLink: $('.js-game')
	},

	init: function() {
		this.bindUIActions();
	},

	bindUIActions: function() {
		Game.config.gameLink.on('click', Game.handleState)
	},

	handleState: function() {
		var link = $(this).find('a').first().attr('href');
		window.location = link;
	}
}