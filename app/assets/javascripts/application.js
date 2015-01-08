// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

//= require bootstrap.min
//= require underscore-min

$(function() { 
	_.compile = function(templ) {
		var compiled = this.template(templ);
		compiled.render = function(ctx) {
			return this(ctx);
		}
		return compiled;
	}
    var places = new Bloodhound({
    	datumTokenizer: Bloodhound.tokenizers.obj.whitespace('name'),
    	queryTokenizer: Bloodhound.tokenizers.whitespace,
        remote: '../search?q=%QUERY'
    });

    places.initialize();

    $('.search-form .typeahead').typeahead(null, {
        name: 'google-places-search',
        source: places.ttAdapter(),
		templates: { 
			suggestion:	_.compile("<p><div><strong><%= name %></strong><span class='grey small'> <%= address%></span></div>" +
					"<div class='grey small'><em><%= place_type %></em></div>" +
					"<div class='grey small'>Rating: <%= rating %></div></p>")
		}
    })
    .on('typeahead:selected', function (obj, datum) {
    	$.ajax({
			url:'../place',
			type:"POST",
			data:JSON.stringify(datum),
			contentType:"application/json; charset=utf-8",
			dataType:"json",
            statusCode: {
                200: function (data) {
                    //var marker = addMarker(map, datum);
                    // get marker
                    var marker = getMarker(data.id);
                    openInfoWindow(map, marker, data);
                    map.panTo(marker.getPosition());
                },
                201: function (data) {
                    var marker = addMarker(map, data);
                    openInfoWindow(map, marker, data);
                    map.panTo(marker.getPosition());
                }
            },
			error: function() { alert('error') }
		})
    });
});