//= require turbolinks
//= require jquery
//= require jquery_ujs
//= require_tree ./objects
//= require underscore
//= require lib/jquery.elastic.js
//= require lib/jquery.events.input.js
//= require lib/jquery-mentions.js

// $(function () {

//   $('textarea.mention').mentionsInput({
//     onDataRequest:function (mode, query, callback) {
//       var data = [
//         { id:1, name:'Kenneth Auchenberg', 'avatar':'http://cdn0.4dots.com/i/customavatars/avatar7112_1.gif', 'type':'contact' },
//         { id:2, name:'Jon Froda', 'avatar':'http://cdn0.4dots.com/i/customavatars/avatar7112_1.gif', 'type':'contact' },
//         { id:3, name:'Anders Pollas', 'avatar':'http://cdn0.4dots.com/i/customavatars/avatar7112_1.gif', 'type':'contact' },
//         { id:4, name:'Kasper Hulthin', 'avatar':'http://cdn0.4dots.com/i/customavatars/avatar7112_1.gif', 'type':'contact' },
//         { id:5, name:'Andreas Haugstrup', 'avatar':'http://cdn0.4dots.com/i/customavatars/avatar7112_1.gif', 'type':'contact' },
//         { id:6, name:'Pete Lacey', 'avatar':'http://cdn0.4dots.com/i/customavatars/avatar7112_1.gif', 'type':'contact' },
//         { id:7, name:'kenneth@auchenberg.dk', 'avatar':'http://cdn0.4dots.com/i/customavatars/avatar7112_1.gif', 'type':'contact' },
//         { id:8, name:'Pete Awesome Lacey', 'avatar':'http://cdn0.4dots.com/i/customavatars/avatar7112_1.gif', 'type':'contact' },
//         { id:9, name:'Kenneth Hulthin', 'avatar':'http://cdn0.4dots.com/i/customavatars/avatar7112_1.gif', 'type':'contact' }
//       ];

//       data = _.filter(data, function(item) { return item.name.toLowerCase().indexOf(query.toLowerCase()) > -1 });

//       callback.call(this, data);
//     }
//   });

//   $('.get-syntax-text').click(function() {
//     $('textarea.mention').mentionsInput('val', function(text) {
//       alert(text);
//     });
//   });

//   $('.get-mentions').click(function() {
//     $('textarea.mention').mentionsInput('getMentions', function(data) {
//       alert(JSON.stringify(data));
//     });
//   }) ;

// });

// $(function () {

//   $('textarea.mention').mentionsInput({
//     onDataRequest:function (mode, query, callback) {
//     	$.ajax({
//     		url: '/users/autocomplete_user_name/',
//     		dataType: 'json',
//     		data: {
//     			term: query
//     		},
//     		success: function(data) {
//     			// console.log(responseData);
//     			callback.call(this, data);
//     		}
//     	})
//     },
//     templates     : {
//       wrapper                    : _.template('<div class="mentions-input-box"></div>'),
//       autocompleteList           : _.template('<div class="mentions-autocomplete-list"></div>'),
//       autocompleteListItem       : _.template('<li data-ref-id="<%= id %>" data-ref-type="<%= type %>" data-display="<%= display %>"><%= content %></li>'),
//       autocompleteListItemAvatar : _.template('<img src="<%= avatar %>" />'),
//       autocompleteListItemIcon   : _.template('<div class="icon <%= icon %>"></div>'),
//       mentionsOverlay            : _.template(''),
//       mentionItemSyntax          : _.template('@[<%= value %>](<%= type %>:<%= id %>)'),
//       mentionItemHighlight       : _.template('<strong><span><%= value %></span></strong>')
//     }

//   });

// });

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
    }
  });

});


$(document).ready(function() {
	App.init();
});


// $.ajax({
// 	url: $('.with_autocomplete').data('autocompleteurl'),
// 	dataType: 'json',
// 	success : function(data) {
// 		console.log(data);
// 		awesome.list=data;
// 	}
// 	});

// $('.with_autocomplete').mentionsInput({source: $('.with_autocomplete').data('autocompleteurl')})

// $('.with_autocomplete').mentionsInput({
// 	onDataRequest:function(mode, query, callback) {
// 		$.getJSON($('.with_autocomplete').data('autocompleteurl'), function(responseData) {
// 			console.log('called');
// 			responseData = _.filter(responseData, function(item) { return item.name.toLowerCase().indexOf(query.toLowerCase()) > -1 });
// 			console.log(responseData);
// 		});
// 	}
// })
// $('.with_autocomplete').on('keypress', function(e) {

// 	if(e.which === 64) {
// 		$('.with_autocomplete').autocomplete({
// 			minLength: 2,
// 			source: function(request, response) {
// 				console.log(request);
// 				return $.ajax({
// 					url: $('.with_autocomplete').data('autocompleteurl'),
// 					dataType: 'json',
// 					data: {
// 						username: request.term
// 					},
// 					success: function(data) {
// 						console.log(data);
// 						return response(data);
// 					},
// 					error: function(xhr, ajaxOptions, thrownError) {
// 						console.log(thrownError);
// 					}
// 				})
// 			}
// 		})
// 	}
// })


// $('.with_autocomplete').textcomplete([
// 	{
// 		match: /(^|\s)@(\w*)$/,
// 		search: function(term, callback) {
// 			$.getJSON($('.with_autocomplete').data('autocompleteurl'), {q: term})
// 			.done(function(resp) { console.log(term); callback(resp); })
// 			.fail(function() { console.log('failed')} );
// 		},
// 		replace: function(value) {
// 			return '$1@' + value + ' ';
// 		},
// 		cache: true
// 	}
// 	], { maxCount: 20, debounce: 500 });

// var cache = [];

// console.log(cache);

// $('.with_autocomplete').textcomplete([
// 	{
// 		match: /(^|\s)@(\w*)$/,
// 		search: function(term, callback) {
// 			callback(cache[term], true);
// 			return $.ajax({
// 				url: $('.with_autocomplete').data('autocompleteurl'),
// 				dataType: 'json',
// 				data: {
// 					username: term
// 				},
// 				success: function(data) {
// 					var x = [];
// 					$.map(data, function(val, i){
// 						x.push(val);
// 					})
// 					callback(x);
// 				},
// 				error: function(xhr, ajaxOptions, thrownError) {
// 					console.log(thrownError);
// 					callback([]);
// 				}
// 			})
// 		},
// 		replace: function(value) {
// 			return '$1@' + value + ' ';
// 		},
// 		cache: true
// 	}
// 	], { maxCount: 20, debounce: 500 });