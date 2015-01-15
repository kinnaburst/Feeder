$(document).on('page:change', function() {
  $('.loading-screen').clearQueue();
  $('.loading-screen').hide();
});

$(document).on('page:fetch submit', function() {
  console.log('loading...');
  $('.loading-screen').delay(300).show({duration:0});
})