var music_info;
var player;
var player_display = false;

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


function youtube_click() {
  music_info = $(this);
  youtube_player();
}

function youtube_player() {
  player_destroy();
  player_button();
  next_button();
  player = new YT.Player('player_block', {
    height: '390',
    width: '640',
    videoId: music_info.data().url,
    events: {
      'onReady': player_launch,
      'onStateChange': onPlayerStateChange,
      'onError': player_error
    }
  });
}

function next_music() {
  music_info = $("li[data-id=\'"+music_info.data().id+"\']").next();
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
      $("#player_position").append("<div id=\"player_block\"></div>");
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
  var music_url = "https://www.soundcloud.com/"+music_info.data().url;
  SC.oEmbed(music_url, { auto_play: true , maxheight: 120, maxwidth: 1000 }, function(oEmbed, error) {
    if (error) { 
      next_music();
    }
    else {
      player = oEmbed.html.replace('visual=true&','');
      player = $('#player_block').html(player);
      setTimeout(soundcloud_listener, 2000 );
    }
  });
}

function player_button(){
  if (player_display) {
    $(".menu").prepend("<span><a id=\"player\">Player [Hide]</a></span>");
  }
  else {
    $(".menu").prepend("<span><a id=\"player\">Player [Show]</a></span>");
  }

  $("#player").on( 'click', function(){ 
    if ( player_display ) {
      $("#player_position").css("display", "none");
      $("#player").html("Player [Show]");
      player_display = false;
    }
    else {
      $("#player_position").css("display", "block");
      $("#player").html("Player [Hide]");
      player_display = true;
    }
  });
}

function next_button(){
  $(".menu").append("<span><a id=\"next\">Next</a></span>");
  $("#next").on( 'click', next_music);
}
