class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  helper_method :current_user

  private

  def authenticate
    redirect_to login_path, notice: "You must log in to access this page" unless session[:user_id]
  end
  #
  def privates_check
    # redirect_to boards_path, notice: "You must log in to access this page"
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
