//= require jquery
//= require jquery_ujs
//= require turbolinks

$('.js-vote').on('click', function(e) {
	e.preventDefault();
	var $this = $(this),
	voted = $this.data('voted'),
	votes = $this.find('.votetext');
	if(voted) {
		$this.removeClass('-voted');
		votes.html(parseInt(votes.html()) - 1);
		$this.data('voted', false);


	} else {
		$this.addClass('-voted');
		votes.html(parseInt(votes.html()) + 1);
		$this.data('voted', true);
	}
});

// Add things back in case of an error

$('.js-vote').on('ajax:error', function(xhr, status, error) {
	var $this = $(this),
	voted = $this.data('voted'),
	votes = $this.find('.votetext');
	if(voted) {
		$this.addClass('-voted');
		votes.html(parseInt(votes.html()) + 1);
		$this.data('voted', true);
	} else {
		$this.removeClass('-voted');
		votes.html(parseInt(votes.html()) - 1);
		$this.data('voted', false);
	}
});