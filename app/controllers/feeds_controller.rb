class FeedsController < ApplicationController

  before_filter :login_check

  def index
    @feeds = @user.feeds.all
  end

  def show
    @feed = current_user.feeds.find(params[:id])
    refresh_feed(user: current_user, feed: @feed)
    @articles = @feed.articles.order(published: :desc)
    if params.has_key?(:page)
      @page = params[:page].to_i
    else
      @page = 1
    end
    @page_size = 5
  end

  def new
    @feed = current_user.feeds.new
  end

  def create
    @feed = Feed.find_by(url: feed_params[:url])
    if @feed.nil? # The feed does not exist yet
      @feed = current_user.feeds.new(feed_params)
      if @feed.valid?
        feed_data = Feedjira::Feed.fetch_and_parse(@feed.url)
        if feed_data == 200
          flash.now[:warning] = 'URL is not a valid RSS feed'
          render 'new'
        else
          current_user.subscriptions.create(feed: @feed)
          @feed.name = feed_data.title
          @feed.save
          create_articles(user: current_user, feed: @feed, entries: feed_data.entries)
          redirect_to @feed
        end
      else
        flash.now[:warning] = @feed.errors.full_messages.join('<br>')
        render 'new'
      end
    else  # The feed already exists
      if current_user.feeds.find_by(url: @feed.url).nil?
        current_user.subscriptions.create(feed: @feed)
        redirect_to @feed
      else  # The user is already subscribed
        flash[:notice] = "You are already subscribed to #{@feed.name}"
        redirect_to @feed
      end
    end
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

  def default_url_options(options={})
    { username: params[:username] }
  end


  private

    def feed_params
      params.require(:feed).permit(:url)
    end

end
