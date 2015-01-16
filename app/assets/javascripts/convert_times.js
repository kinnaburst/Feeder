var dateOptions = {
  month: 'short',
  day: 'numeric',
  hour: 'numeric',
  minute: '2-digit'
}; // Jan 1, 8:00 AM

$(document).on('page:change', function() {

  var articles = $('.article');
  
  $.each(articles, function(index, article) {
    var cell = $(this).find('td:last');
    var date = new Date(cell.html() + ' UTC');
    cell.html(date.toLocaleString('en', dateOptions));
  });

});