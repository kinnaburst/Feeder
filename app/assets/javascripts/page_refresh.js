RELOAD_TIME = 15 * 60 * 1000  // 15 minutes

$(document).on('page:change', function() {

  // Only reload the page if it has articles on it
  if ($('.article').length > 0) {
    setTimeout(reloadPage, RELOAD_TIME);
  }

});

function reloadPage() {
  location.reload();
}