var App = {
  el : {
    gameLink: $('.js-game'),
    gameLinks: $('.js-game a'),
    dropdown: $('.profile-menu .avatar'),
    replyBtn: $('.js-reply'),
    comment: $('textarea.mention'),
    menuBtn: $('.hamburger')
  },

  init: function() {
    this.bindUIActions();
  },

  bindUIActions: function() {
    App.el.gameLink.on('click', App.handleGameState)
    App.el.gameLinks.on('click', App.stopProp)
    App.el.dropdown.on('click', App.handleDropdownToggle)
    App.el.replyBtn.on('click', App.handleReplyForm)
    App.el.comment.mentionsInput({
      onDataRequest: App.handleComment,
      onCaret: true
    });
    App.el.menuBtn.on('click', App.toggleMenu)
  },

  stopProp: function(e) {
    e.stopPropagation();
  },

  handleGameState: function() {
    var link = $(this).find('a').first().attr('href');
    window.location = link;
  },

  handleDropdownToggle: function(e) {
    e.preventDefault();
    $(this).next('.dropdown-menu').toggle();
  },

	handleReplyForm: function(e) {
		var authors = '',
			commentAuthors = $(this).parents('.comment-block'),
			replyBlock = $(this).closest('.replies-header').next('.replies-block').find('.reply-form');

		$.each(commentAuthors, function(i, val) {
			if(i !== 0) {
				authors+= ' ';
			}
			authors+= '@' + $(val).data('comment-author');
		});

		replyBlock.toggle();
		replyBlock.find('textarea').val(authors + ' ');

		$(this).toggleClass('blue');
	},

  toggleMenu: function(e) {
    e.preventDefault();
    $('#navbar').toggleClass('show-nav');
  },

  handleComment: function(mode, query, callback) {
    $.ajax({
      url: '/users/autocomplete_user_name/',
      dataType: 'json',
      data: {
        term: query
      },
      success: function(data) {
        callback.call(this, data);
      }
    });
  }
}
