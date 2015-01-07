module FeedsHelper

  def refresh_feed(feed, override_update = false)
    refresh_urls [feed.url], override_update
  end

  def refresh_urls(urls, override_update = false)
    articles = Array.new

    urls.each do |url|
      user_feed = Feed.find_by(url: url)

      if (override_update or !user_feed.last_updated or user_feed.last_updated.advance(hours: 1) < DateTime.now)

        feed = Feedjira::Feed.fetch_and_parse url

        feed.entries.each do |entry|
          a = Article.find_by(link: entry.url)
          if !a
            a = user_feed.articles.new
            a.title = entry.title
            a.author = entry.author
            a.posted = entry.published
            a.snippet = entry.summary
            a.link = entry.url
            a.save
          end
          articles.push a
        end

        user_feed.last_updated = DateTime.now
        user_feed.save

      else

        articles += user_feed.articles

      end
    end

    articles
  end
  
end
