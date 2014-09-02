function music_player() {
  
  document.getElementById("music_player").innerHTML = 
    "<iframe id=\"ytplayer\" type=\"text/html\" width=\"640\" height=\"390\" src=\""+$(this).data().link+"?autoplay=1\" frameborder=\"0\"/>";
}


$( ".clickable_links" ).each(function() {
  $(this).on( 'click', music_player );
});
