//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require underscore
//= require lib/jquery.events.input.js
//= require lib/jquery-mentions.js
//= require_tree ./objects

$(document).ready(function() {
	App.init();

  $(function () {
    $('textarea.mention').mentionsInput({
      onDataRequest:function (mode, query, callback) {
       $.ajax({
              url: '/users/autocomplete_user_name/',
              dataType: 'json',
              data: {
                term: query
              },
              success: function(data) {
                callback.call(this, data);
              }
            })
      },
      onCaret: true
    });
  });
});