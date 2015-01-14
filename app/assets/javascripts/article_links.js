$(document).on('page:change', function() {
  $('tr').on('click', function() {
    window.open($(this).data('url'));
  });
});