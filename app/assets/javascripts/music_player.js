function music_player() {
  $.get("/musics/"+$(this).data().id, function( data ) {
    $( "#music_player" ).html( data );
  }); 
}

$( ".clickable_links" ).each(function() {
  $(this).on( 'click', music_player );
});
