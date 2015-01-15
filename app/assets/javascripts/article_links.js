$(document).on('page:change', function() {
  $('tr').on('click', function() {
    var url = $(this).data('url');
    if(url.length > 0) {
      window.open(url);
    }
  });
});