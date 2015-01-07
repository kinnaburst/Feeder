class FeedsController < ApplicationController

  def index
    @feeds = Feed.all
  end

  def show
    @feed = Feed.find(params[:id])
    @articles = refresh_feed(@feed)
  end

  def new
    @feed = Feed.new
  end

  def create
    @feed = Feed.create(feed_params)
    refresh_feed(@feed)
    redirect_to @feed
  end

  def edit
    @feed = Feed.find(params[:id])
  end

  def update
    feed = Feed.find(params[:id])
    feed.update(feed_params)
    flash[:notice] = 'Feed updated.'
    redirect_to feed
  end

  def destroy
    feed = Feed.find(params[:id])
    feed.destroy
    flash[:notice] = 'Feed deleted.'
    redirect_to feeds_url
  end

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


  private

    def feed_params
      params.require(:feed).permit(:name, :url)
    end
end
