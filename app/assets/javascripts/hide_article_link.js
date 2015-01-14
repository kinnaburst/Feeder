$(document).on('page:change', function() {
  $('.hide-article-btn').on('click', function(e) {
    e.stopPropagation();
    hideArticle($(this).parents('tr'));
  });
});

function hideArticle(row) {
  var hide_url = row.data('hide-url');
  row.remove();
  $.get(hide_url).always(function() {
    location.reload();
  });
}