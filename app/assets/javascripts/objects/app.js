var App = {
	el : {
		gameLink: $('.js-game'),
		hasTooltip: $('.has-tooltip')
	},

	init: function() {
		this.bindUIActions();
	},

	bindUIActions: function() {
		App.el.gameLink.on('click', App.handleGameState)
		App.el.hasTooltip.on('mouseover', App.handleTooltipOver)
	},

	handleGameState: function() {
		var link = $(this).find('a').first().attr('href');
		window.location = link;
	},

	handleTooltipOver: function() {
		var el = $(this);
		var text = el.data('tooltip');
		var tooltip = jQuery('<div/>', {
			text: text,
			class: 'tooltip'
		});

		el.closest('a').append(tooltip);

		var top = el.position().top + el.height();
		var left = el.position().left;

		tooltip.css('top', top);
		tooltip.css('left', left);

		el.on('mouseout', function(){
			tooltip.remove();
		});
	}
}
