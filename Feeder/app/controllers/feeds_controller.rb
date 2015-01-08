class FeedsController < ApplicationController

  before_filter :login_check

  def index
    @feeds = @user.feeds.all
  end

  def show
    @feed = current_user.feeds.find(params[:id])
    @articles = refresh_feed(@feed)
  end

  def new
    @feed = current_user.feeds.new
  end

  def create
    feed = current_user.feeds.create(feed_params)
    refresh_feed(feed)
    redirect_to feed
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
      params.require(:feed).permit(:name, :url)
    end

end
