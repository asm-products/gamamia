var App = {
	el : {
		gameLink: $('.js-game'),
		dropdown: $('.profile-menu .avatar'),
		comment: $('textarea.mention')
	},

	init: function() {
		this.bindUIActions();
	},

	bindUIActions: function() {
		App.el.gameLink.on('click', App.handleGameState);
		App.el.dropdown.on('click', App.handleDropdownToggle);
	},

	handleGameState: function() {
		var link = $(this).find('a').first().attr('href');
		window.location = link;
	},

	handleDropdownToggle: function(e) {
		e.preventDefault();
		$(this).next('.dropdown-menu').toggle();
	}
}