class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def not_found
      raise ActionController::RoutingError.new('Not Found')
  end

  def current_user
      @current_user ||= User.find_by_id(session[:user_id])
  end

  def logged_in?
      current_user != nil
  end

  def authorize
      redirect_to login_path unless logged_in?
  end

  def check_admin
      unless logged_in? and current_user.admin?
        render :status => :forbidden, :text => "Permission denied"
      end
  end
end
