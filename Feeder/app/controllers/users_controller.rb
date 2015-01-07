class UsersController < ApplicationController

  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    redirect_to user
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def login
  end


  private

    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation)
    end

end
