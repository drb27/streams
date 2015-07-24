require 'streamsmeta'
require 'streamsmsg'

class ApplicationController < ActionController::Base

  # Use Pundit for user authorization
  include Pundit

  # By default, ask for login
  @login_redirect = true

  def self.login_redirect?
    if self.instance_variables.include? :@login_redirect
      @login_redirect
    else
      self.superclass.login_redirect?
    end
  end
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected 

  # User login management

  def retrieve_user

    if session[:user_id]
      begin
        @current_user = User.find session[:user_id]
      rescue StandardError
        @current_user = false
        session.delete :user_id
      end
    else
      @current_user = false
    end
  end

  def init_messages
    @messages = StreamsMsg.new

    if flash[:messages] != nil
      @fmessages = StreamsMsg.new flash[:messages]["messages"], flash[:messages]["severity"]
    else
      @fmessages = StreamsMsg.new
    end
  end

  def stage_messages
    flash[:messages] = @messages.to_hash
  end

  def flush_messages
    @fmessages = StreamsMsg.new @messages.messages, @messages.severity
    @messages = StreamsMsg.new
  end

  def authenticate_user
    if @current_user
      return true
    else
      session[:return_to] = request.fullpath
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

  def current_user
    return @current_user
  end

  def access_denied
    if self.class.login_redirect?
      session[:return_to] = request.fullpath
      redirect_to :controller => 'sessions', :action => 'login'
    else
      redirect_to :controller => 'sessions', :action => 'denied'
    end
  end

  def init_sidebar
    @pinned = Workstream.where :pinned => true
  end

  # All Pundit access violations get handled by this
  rescue_from Pundit::NotAuthorizedError, :with => :access_denied
  
  before_filter :retrieve_user,:init_messages,:init_sidebar
  after_filter :stage_messages

end
