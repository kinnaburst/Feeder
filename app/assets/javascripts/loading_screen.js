$(document).on('page:change', function() {
  $('.loading-screen').clearQueue();
  $('.loading-screen').hide();
});

$(document).on('page:fetch', function() {
  $('.loading-screen').show();
})