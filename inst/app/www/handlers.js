$( document ).ready(function() {
  Shiny.addCustomMessageHandler('shownid', function(id) {
    $( "#" + id ).trigger("show");
    $( "#" + id ).trigger("shown");
  });
  
  Shiny.addCustomMessageHandler('succes',function(id){
    $( "#" + id ).fadeIn(300).delay(3000).fadeOut(300);
  });
  
});
