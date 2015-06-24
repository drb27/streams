class ApplicationController < ActionController::Base

  # Use Pundit for user authorization
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    return "drb"
  end
end
