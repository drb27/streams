class ApplicationController < ActionController::Base

  # Use Pundit for user authorization
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected 

  # User login management

  def retrieve_user
    if session[:user_id]
      @current_user = User.find session[:user_id]
    else
      @current_user = false
    end
  end

  def authenticate_user
    if @current_user
      return true
    else
      redirect_to( :controller => 'sessions', :action => 'login')
      return false
    end
  end

  def save_login_state
    if session[:user_id]
      redirect_to(:controller => 'sessions', :action => 'home')
      return false
    else
      return true
    end
  end

before_filter :retrieve_user
  
end
