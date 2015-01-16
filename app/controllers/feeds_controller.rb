class FeedsController < ApplicationController

  before_filter :login_check

  def index
    @feeds = @user.feeds.order(name: :asc)
  end

  def show
    @feed = current_user.feeds.find(params[:id])
    refresh_feed(user: current_user, feed: @feed)
    @articles = @feed.articles.order(published: :desc)
  end

  def new
    @feed = current_user.feeds.new
  end

  def create
    @feed = Feed.find_by(url: feed_params[:url])
    if @feed.nil? # The feed does not exist yet
      create_feed
    else  # The feed already exists
      if current_user.feeds.find_by(url: @feed.url).nil?
        subscribe_to_feed @feed
      else  # The user is already subscribed
        flash[:notice] << "You are already subscribed to #{@feed.name}"
        redirect_to @feed
      end
    end
  end

  def edit
    @feed = Feed.find(params[:id])
  end

  def update
    feed = Feed.find(params[:id])
    if feed.update(feed_params)
      flash[:notice] << 'Feed updated'
    else
      flash[:warning] << 'Unable to update feed'
    end
    redirect_to feed
  end

  def destroy
    feed = Feed.find(params[:id])
    sub = current_user.subscriptions.find_by(feed: feed)
    sub.destroy
    flash[:notice] << 'Feed deleted'
    redirect_to feeds_url
  end

  def default_url_options(options={})
    { username: params[:username] }
  end


  private

    def feed_params
      params.require(:feed).permit(:url)
    end

    def create_feed
      @feed = current_user.feeds.new(feed_params)

      if @feed.valid?
        feed_data = Feedjira::Feed.fetch_and_parse(@feed.url)
        if feed_data == 200 # Invalid RSS feed
          flash.now[:warning] << 'URL is not a valid RSS feed'
          render 'new'
        else
          @feed.name = feed_data.title
          @feed.last_updated = DateTime.now
          @feed.save
          subscribe_to_feed @feed, feed_data
        end
      else
        flash.now[:warning] += @feed.errors.full_messages
        render 'new'
      end
    end

    def subscribe_to_feed(feed, feed_data=nil)
      current_user.subscriptions.create(feed: feed)
      create_articles(user: current_user, feed: feed, entries: feed_data.nil? ? nil : feed_data.entries)
      flash[:notice] << "Added #{@feed.name} feed"
      redirect_to feed
    end

end
