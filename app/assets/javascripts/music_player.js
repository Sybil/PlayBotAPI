var music_info;
var player;

$( ".clickable_links" ).each(function() {
  if ($(this).data().player == "youtube" ) {
    $(this).on( 'click', youtube_click);
  }
});

function youtube_click() {
  music_info = $(this);
  youtube_player();
}

function youtube_player() {
  if (player && $("div#music_player").length == 0) {
    player.loadVideoById(music_info.data().url);
  }
  else {
    player = new YT.Player('music_player', {
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
}

function next_music() {
  music_info = $("li[data-id=\'"+music_info.data().id+"\']").next();
  if (music_info.data().player == "youtube" ) {
    youtube_player();
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
