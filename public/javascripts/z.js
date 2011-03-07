var redactor = {
  focus: true,
  path: '/redactor/',
  image_upload: '/dashboard/asset_photos',
  file_upload:  '/dashboard/assets',
  pathCss: '../stylesheets/',
  css: ['e.css'],
  lang: 'en'
};

$(function() {
  $(".date_picker").datepicker({
    showOn: "both",
    buttonImage: "/images/calendar_3.png",
    buttonImageOnly: true,
    dateFormat: "yy-mm-dd"
  });
  $(".flash").delay(5000).slideUp("fast").live("click", function() {$(this).slideUp("fast")});
  $('#more_results a').click(function () {
    get_more_all_rests();
    return false;
  });
  init_mark_favorites();
  mark_favourites();
  init_paginator();
});

var SLIDER_MIN = 20;
var SLIDER_MAX = 260;
var SLIDER_CURRENT_MIN = SLIDER_MIN;
var SLIDER_CURRENT_MAX = SLIDER_MAX;
var SLIDER_MIN_STEP = 10;

function init_slider() {
  hash = window.location.hash;
  info = hash.replace('#', '').split(',');
  min = SLIDER_CURRENT_MIN;
  max = SLIDER_CURRENT_MAX;
  if (info.length == 2) {
    min = parseInt(info[0]);
    max = parseInt(info[1]);
  }
  $("#slider-range").slider({
    range: true,
    min: SLIDER_MIN,
    max: SLIDER_MAX,
    values: [min, max],
    step: SLIDER_MIN_STEP,
    slide: function(event, ui) {
      if (Math.abs(ui.values[0] - ui.values[1]) < SLIDER_MIN_STEP) {
        return false;
      }
      else {
        $("#current_min").attr("value", ui.values[0]);
        $("#current_max").attr("value", ui.values[1]);
        $("#amount").val(money(ui.values[0]) + " — " + money(ui.values[1]));
        return true;
      }
    },
    stop: function(event, ui) {
      window.location.hash = '#' + ui.values[0] + ',' + ui.values[1];
      get_all_rests();
    }
  });
  if (max != SLIDER_CURRENT_MAX) {
    $("#current_min").attr("value", min);
    $("#current_max").attr("value", max);
    get_all_rests();
  }
};

function money(amount) {
  if (amount == SLIDER_MAX) {
    return amount + '+ грн';
  } else {
    return amount + ' грн';
  }
};

function init_header_autocomplete() {
  if ($('#q').length) {
    $('#q').autocomplete({
      minLength: 2,
      source: $('#q').attr('data-autocomplete'),
      select: function(event, ui) {
        window.location = ui.item.href;
        return false;
      }
    }).data( "autocomplete" )._renderItem = function( ul, item ) {
      return $( "<li></li>" )
        .data( "item.autocomplete", item )
        .append( "<a><strong>" + item.name + "</strong><span>" + item.address + "</span></a>")
        .appendTo( ul );
    };
	}
};

function ajax_rests (callback, except_rest_ids) {
  $.ajax({
    url: $('span.dropdown > #selected > a').attr('href'),
    data: $.param({
      min_price: $('#current_min').attr('value'),
      max_price: $('#current_max').attr('value'),
      '[rest_ids]': except_rest_ids || []
    }),
    success: callback,
    beforeSend: function (xhr) {
                  $('.loader').show();
                  xhr
                },
    complete: function(xhr, status) {
                $('.loader').hide();
              }
  });
};

function get_all_rests () {
  ajax_rests(function (response) { 
    $('#all_rests').html(response); 
    mark_favourites();
    $('.paginator').find('a.paginator_item:first').addClass('act');
  });
};

function get_more_all_rests () {
  ajax_rests(function (response) {
    $('#all_rests').append(response);
    mark_favourites();
    $('.paginator').find('a.paginator_item:first').addClass('act');
  }, rest_ids());
};

function rest_ids () {
  var rest_ids = [];
  $('#all_rests .content_item').each(function () {
    rest_ids.push($(this).attr('data-item').match(/\d+$/)[0]);
  });
  return rest_ids.join(',');
};

function get_favourite_ids () {
  return $.cookie('favourite_ids') ? $.cookie('favourite_ids').split(',') : []
};

function set_favourite_ids (array) {
  $.cookie('favourite_ids', array.toString(), { expires: 7*52, path: '/' });
  get_favourite_ids();
};

function mark_favourites () {
  var ff = get_favourite_ids();
  $('a.add').each(function () {
    if ($.inArray(this.id.match(/\d+$/)[0], ff) > -1) { $(this).addClass('active') }
  });
  return false;
};

function init_mark_favorites() {
  $('a.add').live('click', function () {
    $(this).toggleClass('active');
    var user_id = this.id.match(/\d+$/)[0];
    var fav_ids = get_favourite_ids();
    if ($.inArray(user_id, fav_ids) > -1) { 
      fav_ids.splice($.inArray(user_id, fav_ids), 1);
    } else {
      fav_ids.push(user_id)
    }
    set_favourite_ids(fav_ids);
    return false;
  }).removeAttr('href');
};

function init_tooltip() {
  $('.tip:not(.processed)').each(function () {
    $(this).qtip({
      show: 'mouseover',
      hide: 'mouseout', 
      style: {
        width: $(this).attr('title').length * 15,
        name: 'cream', 
        tip: 'bottomLeft',
        background: '#f8f6ca',
        color: '#797145',
        textAlign: 'center',
        fontStyle: 'italic',
        border: {
          width: 1,
          radius: 1,
          color: '#ddcf7f'
        }
      },
      position: {
        corner: {
           target: 'topMiddle',
           tooltip: 'bottomLeft'
        }
      }
    }).addClass('processed');
  });
};

function init_paginator() {
  $('.paginator').find('a.paginator_item:first').addClass('act');
  
  function load_image(_this) {
    var img = $("<img />");
    $(img).bind('load', function() {
      $(_this).parents('.paginator').find('.small_loader').fadeOut();
    }).attr("src", _this.id);
    return img;
  }

  $('.paginator a.paginator_item').live('click', function () {
    $(this).siblings().removeClass('act');
    $(this).addClass('act');
    var parent = $(this).parents('.paginator');
    parent.find('.small_loader').show();
    parent.parent().find('.img_wrap .img img').replaceWith(load_image(this));
    return false;
  })
  
  $('.paginator > a.prev').live('click', function () {
    var prev_pagination_item = $(this).siblings('.paginator_item.act').prev('.paginator_item');
    if (prev_pagination_item.length) {
      prev_pagination_item.click();
    } else {
      $(this).siblings('.paginator_item:last').click();
    }
    return false;
  });
  
  $('.paginator > a.next').live('click', function () {
    var next_pagination_item = $(this).siblings('.paginator_item.act').next('.paginator_item');
    if (next_pagination_item.length) {
      next_pagination_item.click();
    } else {
      $(this).siblings('.paginator_item:first').click();
    }
    return false;
  });
  
  $('.img_wrap .img a').click(function () {
    //$(this).parents('.content_item').find('.paginator a.next').click();
    //return false;
  }); 
};

function load_image_for_rest(_this) {
  var img = $("<img />");
  $(img).bind('load', function() {
    $(_this).parents('#rest_show').find('.small_loader').fadeOut();
  }).attr("src", _this.attr('data-to'));
  return img;
}

function slide_rest_images() {
  $('#rest_photos .rest_of_photos img').click(function() {
    _this = $(this);
    $('#rest_show .small_loader').show();
    $('#rest_photos .preview img').replaceWith(load_image_for_rest(_this));
  });
};

function preview_rest_rooms() {
  $('.rest_room_photos a').colorbox();
};

function preview_tour_gallery() {
  $('.tour_gallery a').colorbox();
};

function init_hidden_content() {
  $('.hidden').find('*').hide().end().append("<span class='show_me'>show</span>").find(".show_me").click(function(){
    $(this).parent().find('.show_me').remove().end().find("*").show();
  });
};

function scroll_to_comments() {
   var x = $("#comments").offset().top - 100; // 100 provides buffer in viewport
   $('html,body').animate({scrollTop: x}, 500);
}

function init_show_n_symbols(from, to) {
  function show_len() {
    $(to).html("Symbols: " + $(from).val().length);
  };
  $(from).keyup(show_len);
  $(from).change(show_len);
};

function init_locate_map(arr) {
  var latlng = new google.maps.LatLng(arr[0], arr[1]);
  var myOptions = {
    zoom: 11,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  var map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
  var marker = new google.maps.Marker({
    position: latlng, 
    map: map,
    title: arr[3],
    draggable: true
  });
  google.maps.event.addListener(marker, 'dragend', function() {
    $("#lat").val(marker.getPosition().lat());
    $("#lng").val(marker.getPosition().lng());
    $("#accuracy").val(map.getZoom());
  });
};

var map;
var markers = {};
var infowindow;

function init_show_map(arr) {
  var latlng = new google.maps.LatLng(arr[0], arr[1]);
  var myOptions = {
    zoom: 12,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
  var marker = new google.maps.Marker({
    position: latlng, 
    map: map,
    title: arr[3]
  });
  google.maps.event.addListener(map, 'idle', function() {
		loadPhotos();
	});
  google.maps.event.addListener(map, 'click', function() {
		infowindow.close();
	});
	infowindow = new google.maps.InfoWindow();
};

function loadPhotos() {
	var url = 'http://www.panoramio.com/map/get_panoramas.php?order=popularity&set=public&from=0&to=20&size=mini_square&callback=addPhotos';
	var bounds = map.getBounds();
	url += '&minx=' + bounds.getSouthWest().lng().toFixed(6) + '&miny=' + bounds.getSouthWest().lat().toFixed(6);
	url += '&maxx=' + bounds.getNorthEast().lng().toFixed(6) + '&maxy=' + bounds.getNorthEast().lat().toFixed(6);
	url += '&ts=' + new Date().getTime(); // prevent caching

  // use JSONP to retrieve photo data and trigger a callback to addPhotos()
  var script = document.createElement("script");
  script.setAttribute("src", url);
  script.setAttribute("type", "text/javascript");                
  document.body.appendChild(script);
};

// add new markers
function addPhotos(data) {
	var new_markers = {};

	if (data.photos && data.photos.length) {
		for (var i = 0; i < data.photos.length; i++) {
			var photo = data.photos[i]; 
		
			// for speed and to reduce flicker, reuse existing markers rather than removing and re-adding
			if (photo.photo_id in markers) {
				new_markers[photo.photo_id] = markers[photo.photo_id];
			
			} else {
				// create new marker
				marker = new google.maps.Marker({
					position: new google.maps.LatLng(photo.latitude, photo.longitude),
					icon: photo.photo_file_url,
					map: map
				});

        addClickHandler(marker, photo);
				new_markers[photo.photo_id] = marker;
			}
		}
	}

	// remove old markers
	for (var photo_id in markers) {
		if (!(photo_id in new_markers)) {
			markers[photo_id].setMap(null);
			delete markers[photo_id];
		}
	}
	markers = new_markers;
};

function addClickHandler(marker, photo) {
	google.maps.event.addListener(marker, 'click', function() {
	  infowindow.close();
    infowindow.setContent('<div style="padding: 7px;min-height: 100px;"><img src="http://mw2.google.com/mw-panoramio/photos/small/' + photo.photo_id + '.jpg" /></div>');
    infowindow.open(map, marker);
	});
};