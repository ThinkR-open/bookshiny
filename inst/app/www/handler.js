$( document ).ready(function() {
  Shiny.addCustomMessageHandler('trigger', function(id) {
     $( '#' + id ).show();
     $( '#' + id ).trigger('show');
     $( '#' + id ).trigger('shown');
  })
});
