var music_info;
var player;
var player_expand = false;
var player_min;
var player_max;

$("#menu_button").on('click', function () {
  $(".menu_toggleable").toggle();
});

$( ".clickable_links" ).each(function() {
  if ($(this).data().player == "youtube" ) {
    $(this).on( 'click', youtube_click);
  }
  else if ($(this).data().player == "soundcloud" ) {
    $(this).on( 'click', soundcloud_click);
  }
});

$("a").on( 'click', function(event){
    event.stopPropagation();
});

$( document ).ready(function () {
  if ($(location).attr("hash") == "#autoplay=on") {
    $(".clickable_links").first().trigger('click');
  }
});

function youtube_click() {
  music_info = $(this);
  youtube_player();
}

function youtube_player() {
  player_destroy();
  player_button();
  next_button();

  var player_height;
  if (player_expand) { player_height = 390; }
  else { player_height = 30; }

  player = new YT.Player('player_block', {
    height: player_height,
    width: '640',
    videoId: music_info.data().url,
    events: {
      'onReady': player_launch,
      'onStateChange': onPlayerStateChange,
      'onError': player_error
    }
  });
  
  var white_top = $("#header").height();
  $("#white").css({'height':white_top}).slideDown();
  player_min = 30;
  player_max = 390;
}

function next_music() {
  music_info = $("li[data-id=\'"+music_info.data().id+"\']").next();
  if (music_info.length == 0) {
    next_page = $(".next a").attr('href')
    if ( next_page.length != 0 ){
      window.location.href = next_page+"#autoplay=on";
    }
  }
  if (music_info.data().player == "youtube" ) {
    youtube_player();
  }
  else if (music_info.data().player == "soundcloud" ) {
    soundcloud_player();
  }
  else {
    next_music();
  }
}

function onPlayerStateChange(event) {
  if (event.data == 0) {
    next_music();
  }
}
function player_error(event) {
  next_music();
}
function player_launch(event) {
  event.target.playVideo();
}



function soundcloud_click() {
  music_info = $(this);
  soundcloud_player();
}

function player_destroy() {
  $("#on_play").removeAttr("id");
  music_info.attr("id", "on_play");

  $("#player").remove();
  $("#next").remove();

  if (player) {
    if ($("#player_block").length == 0) {
      $("#player_position").html("<span id=\"player_block\"></span>");
    }

    try {
      player.destroy();
    }
    catch(e) {}

    try {
      var iframe = document.querySelector('iframe');
      iframe.parentNode.removeChild(iframe);
    }
    catch(e) {}
  } 
}

function soundcloud_listener() {
    var iframe = document.querySelector('iframe');
    var widget = SC.Widget(iframe);
    widget.bind(SC.Widget.Events.READY, function() {
      widget.bind(SC.Widget.Events.FINISH, next_music);
    });
}

function soundcloud_player() {
  player_destroy();
  player_button();
  next_button();

  var player_height;
  if (player_expand) { player_height = 120; }
  else { player_height = 20; }

  var music_url = "https://www.soundcloud.com/"+music_info.data().url;
  SC.oEmbed(music_url, { auto_play: true , maxheight: player_height, maxwidth: 1000 }, function(oEmbed, error) {
    if (error) { 
      next_music();
    }
    else {
      player = oEmbed.html.replace('visual=true&','');
      player = $('#player_block').html(player);
      setTimeout(soundcloud_listener, 2000 );
    }
  });
 
  $("#white").css({'height':68+player_height}).slideDown();
  player_min = 20;
  player_max = 120;
}

function player_button(){
  if (player_expand) {
    $("#player_button").html("<a id=\"player\">Player [Reduce]</a>");
  }
  else {
    $("#player_button").html("<a id=\"player\">Player [Expand]</a>");
  }

  $("#player").on( 'click', function(){
    if ( player_expand ) {
      $("iframe").attr('height', player_min);
      $("#player").html("Player [Expand]");
      player_expand = false;

    }
    else {
      $("iframe").attr('height', player_max);
      $("#player_position").slideDown();
      $("#player").html("Player [Reduce]");
      player_expand = true;
    }  
    var white_top = $("#header").height();
    $("#white").css({'height':white_top}).slideDown();
  });
}

function next_button(){
  $("#next_button").html("<a id=\"next\">Next</a>");
  $("#next").on( 'click', next_music);
}
