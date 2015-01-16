$(document).on('page:change', function() {

  var closeFlashBtn = $('.flash').find('.close-link');

  closeFlashBtn.on('click', function(e) {
    $(this).parent('.flash').remove();
  });
  
});