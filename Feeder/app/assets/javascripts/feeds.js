var feed_data = null;
var urls = [];
var feeds = [];
var num_urls = 0;
var url_count = 0;
var articles = [];
var timer = null;

var REFRESH_INTERVAL = 30 * 60 * 1000;

$(document).on('page:change', function() {
	articles = [];
	url_count = 0;
	if(timer != null) {
		clearTimeout(timer);
	}

	feed_data = $('.feed_data');
	feeds = feed_data.data('names');
	urls = feed_data.data('urls');
	if(urls) {
		load_feeds();
	}
});

function load_feeds() {
	num_urls = urls.length;
	for(var i = 0; i < num_urls; i++) {
		parseRSS(urls[i], url_loaded);
	}
}

function parseRSS(url, callback) {
  $.ajax({
    url: document.location.protocol + '//ajax.googleapis.com/ajax/services/feed/load?v=1.0&num=10&callback=?&q=' + encodeURIComponent(url),
    dataType: 'json',
    success: function(data) {
      callback(data.responseData.feed);
    }
  });
}

function url_loaded(data) {
	entries = data.entries
	for (var i = 0; i < entries.length; i++) {
		var feed = feeds[urls.indexOf(data.feedUrl)]
		var entry = entries[i];
		articles.push(new Article(feed, entry.title, entry.author, entry.publishedDate,
									entry.contentSnippet, entry.link));
	}
	url_count++;
	console.log("URL count: " + url_count);
	if (url_count == num_urls) {
		all_urls_loaded();
	}
}

function all_urls_loaded() {
	articles.sort(function(left, right) {
		if (left.date < right.date) {
			return -1;
		}
		if (left.date > right.date) {
			return 1;
		}
		return 0;
	}).reverse();

	feed_data.html('');

	for(var i = 0; i < articles.length; i++) {
		feed_data.append('<article><h2><a href="' + articles[i].link + '">' + articles[i].title + '</a></h2></article>' + 
			'<p class="details">Written by ' + articles[i].author + ' on ' + articles[i].date.toLocaleString() + '</p>' +
			'<p>' + articles[i].snippet + '</p>');
	}

	timer = window.setTimeout(load_feeds, REFRESH_INTERVAL);
}

function Article(feed, title, author, date, snippet, link) {
	this.feed = feed;
	this.title = title;
	this.author = author;
	this.date = new Date(date);
	this.snippet = snippet;
	this.link = link;
}