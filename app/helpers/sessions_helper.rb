module SessionsHelper

  def login(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def logout
    session.delete :user_id
  end

  def logged_in?
    !current_user.nil?
  end

  def login_check
    @user = User.find_by(username: params[:username])

    if !logged_in?
      flash[:warning] = 'You must be logged in or create an account.'
      redirect_to login_url and return
    end

    if @user.nil?
      return
    end

    if current_user.id != @user.id
      flash[:warning] = 'You can only view and edit your account.'
      redirect_to user_url(username: current_user.username) and return
    end
  end

end
