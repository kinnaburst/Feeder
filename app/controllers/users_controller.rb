  class UsersController < ApplicationController

  before_filter :login_check, only: [:show, :edit, :update, :destroy]

  def index
    if logged_in?
      redirect_to user_url(username: current_user.username) and return
    end
  end

  def show
    @user = User.find_by(username: params[:username])
    refresh_feeds(user: @user)
    @articles = @user.articles.where(user_articles: {hidden: false}).order(published: :desc)
    if params.has_key?(:page)
      @page = params[:page].to_i
    else
      @page = 1
    end
    @page_size = 10
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      login @user
      redirect_to user_url(username: @user.username)
    else
      flash.now[:warning] += @user.errors.full_messages
      render 'new'
    end
  end

  def edit
  end

  def update
    if current_user.authenticate(params[:user][:old_password])
      if current_user.update(user_params)
        redirect_to user_path(username: current_user.username)
      else
        flash.now[:warning] += current_user.errors.full_messages
        render 'edit'
      end
    else
      flash.now[:warning] << 'Old password is incorrect'
      render 'edit'
    end
  end

  def destroy
    current_user.delete
    redirect_to root_url
  end

  def hide_article
    user_article = current_user.user_articles.find_by(article_id: params[:id])
    if user_article.nil?
      return
    end

    user_article.hidden = true
    user_article.save
  end

  def default_url_options(options={})
    { username: params[:username] }
  end


  private

    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end

end
