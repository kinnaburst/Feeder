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

end
