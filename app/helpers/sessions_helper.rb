module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember_me
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    @current_user.forget_me
    session.delete(:user_id)
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      digest = user.remember_digest
      token = cookies[:remember_token]
      if user && BCrypt::Password.new(digest).is_password?(token)
        log_in user
        @current_user = user
      end
    end
  end
end
