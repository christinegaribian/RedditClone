class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :require_login, :require_moderator, :require_no_login

  def require_no_login
    # redirect_to_root if current_user
  end 

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def login(user)
    @current_user = user
    session[:session_token] = user.session_token
  end

  def logout
    current_user.reset_session_token
    session[:session_token] = nil
  end

  def require_login
  end

  def require_moderator

  end
end
