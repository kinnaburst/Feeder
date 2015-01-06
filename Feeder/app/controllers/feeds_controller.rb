class FeedsController < ApplicationController
  def index
    @feeds = Feed.all
  end

  def show
    @feed = Feed.find(params[:id])
    @articles = update_articles(@feed)
  end

  def new
    @feed = Feed.new
  end

  def create
    @feed = Feed.create(feed_params)
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


  private

    def feed_params
      params.require(:feed).permit(:name, :url)
    end

    def update_articles(feed)
      data = Feedjira::Feed.fetch_and_parse feed.url
      logger.debug data.inspect
      data.entries.each do |entry|
        a = Article.find_by(link: entry.url)
        if !a
       #   a = Article.new
       #   a.feed = feed.id
       #   a.title = entry.title
       #   a.author = entry.author
       #   a.posted = entry.published
       #   a.snippet = entry.summary
       #   a.link = entry.url
       #   a.save
        end
      end
      #Article.find_by(feed: feed.id)
    end
end
