var currentPage = 1;
var articlesPerPage = 10;

$(document).on('page:change', function () {

  currentPage = 1;
  paginateArticles();

});

function paginateArticles() {

  var articles = $('.articles tr');

  var end = currentPage * articlesPerPage;
  var start = end - articlesPerPage + 1;

  // Decide which articles to show and hide
  $.each(articles, function(index, article) {
    if(index != 0 && (index < start || index > end)) {
      $(article).hide();
    } else {
      $(article).show();
    }
  });

  updatePageControls();

}

function updatePageControls() {

  var maxPages = Math.ceil($('.articles tr').length / articlesPerPage);
  var pageControls = $('.pagination');

  var controlHtml = '';
  controlHtml += '<a href="javascript:prevPage();"><--</a>';
  controlHtml += ' Page ' + currentPage + ' of ' + maxPages + ' '
  controlHtml += '<a href="javascript:nextPage();">--></a>';

  pageControls.html(controlHtml);

}

function prevPage() {

  currentPage = currentPage > 1 ? currentPage-1 : 1;
  paginateArticles();

}

function nextPage() {

  var maxPages = Math.ceil($('.articles tr').length / articlesPerPage);
  currentPage = currentPage < maxPages ? currentPage+1 : maxPages;
  paginateArticles();
  
}