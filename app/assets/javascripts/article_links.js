$(document).on('page:change', function() {

  $('.article').on('click', function() {
    var url = $(this).data('url');
    window.open(url);
  });
  
});