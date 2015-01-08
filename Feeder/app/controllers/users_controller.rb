class UsersController < ApplicationController

  before_filter :login_check, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
    @user = User.find_by(username: params[:username])
    @articles = Array.new
    @user.feeds.all.each do |feed|
      @articles += refresh_feed feed
    end
    @articles.sort! { |a,b| a.posted <=> b.posted }.reverse!
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    login user
    redirect_to user_url(username: user.username)
  end

  def edit
  end

  def update
    logger.debug(params.inspect)
    if current_user.authenticate(params[:user][:old_password])
      current_user.update(user_params)
      redirect_to user_path(username: current_user.username)
    else
      flash.now[:notice] = 'Old password is incorrect.'
      render 'edit'
    end
  end

  def destroy
    current_user.destroy
    redirect_to root_url
  end


  private

    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end

end
