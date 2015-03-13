var App = {
  el : {
    gameLink: $('.js-game'),
    dropdown: $('.profile-menu .avatar'),
    replyBtn: $('.js-reply'),
    comment: $('textarea.mention')
  },

  init: function() {
    this.bindUIActions();
  },

  bindUIActions: function() {
    App.el.gameLink.on('click', App.handleGameState)
    App.el.dropdown.on('click', App.handleDropdownToggle)
    App.el.replyBtn.on('click', App.handleReplyForm)
    App.el.comment.mentionsInput({
      onDataRequest: App.handleComment,
      onCaret: true
    });
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
    $(this).closest('.replies-header').next('.replies-block').find('.reply-form').toggle();
    $(this).toggleClass('blue');
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
