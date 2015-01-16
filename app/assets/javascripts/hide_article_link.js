$(document).on('page:change', function() {

  $('.hide-cell').on('click', function(e) {
    e.stopPropagation();
    hideArticle($(this).parents('tr'));
  });
  
});

function hideArticle(row) {

  var hide_url = row.data('hide-url');
  row.remove();
  paginateArticles();
  $.get(hide_url);
  
}