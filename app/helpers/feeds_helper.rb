module FeedsHelper

  def refresh_feeds(**args)
    # Check for require keys (:user)
    if not args.has_key?(:user)
      return
    end

    user = args[:user]

    if args.has_key?(:feed)
      feed = args[:feed]
      refresh_feed(feed: feed, user: user)
    else
      user.feeds.all.each do |feed|
        refresh_feed(feed: feed, user: user)
      end
    end
  end

  def refresh_feed(**args)
    # Check for require keys (:feed)
    if not args.has_key?(:feed)
      return
    end

    feed = args[:feed]

    if feed.last_updated.nil? or feed.last_updated.advance(minutes: 15) < DateTime.now
      if args.has_key?(:user)
        create_articles(feed: feed, user: args[:user])
      else
        create_articles(feed: feed)
      end
      feed.last_updated = DateTime.now
      feed.save
    end
  end

  def get_feed_title(**args)
    # Check for require keys (:feed)
    if not args.has_key?(:feed)
      return
    end

    feed = args[:feed]
    @data ||= Feedjira::Feed.fetch_and_parse feed.url

    @data.title
  end

  def get_feed_entries(**args)
    # Check for require keys (:feed)
    if not args.has_key?(:feed)
      return
    end

    feed = args[:feed]
    @data ||= Feedjira::Feed.fetch_and_parse feed.url

    @data.entries
  end

  def create_articles(**args)
    # Check for required keys (:feed)
    if not args.has_key?(:feed)
      return
    end

    feed = args[:feed]
    entries = args.has_key?(:entries) ? args[:entries] : get_feed_entries(feed: feed)

    entries.each do |entry|
      a = Article.find_by(url: entry.url)
      if a.nil?
        a = feed.articles.new
        a.title = entry.title
        a.published = entry.published
        a.save
      end
    end

    if args.has_key?(:user)
      user = args[:user]
      create_user_articles(user: user, feed: feed)
    end
  end

  def create_user_articles(**args)
    # Check for required keys (:user, :feed)
    if not args.has_key?(:user) or not args.has_key?(:feed)
      return
    end

    user = args[:user]
    articles = args[:feed].articles

    articles.each do |article|
      if user.user_articles.find_by(article: article).nil?
        user.user_articles.create(article: article)
      end
    end
  end

end
