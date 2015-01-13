RELOAD_TIME = 15 * 60 * 1000  // 15 minutes

$(document).on('page:change', function() {
  setTimeout(reloadPage, RELOAD_TIME);
});

function reloadPage() {
  window.location.href = document.location.href
}