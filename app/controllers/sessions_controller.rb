class SessionsController < ApplicationController

  before_filter :authenticate_user, :only => [:home, :profile, :setting]
  before_filter :save_login_state, :only => [:login, :login_attempt]

  def denied
    render :denied, status: 401
  end
  
  def login
    @redirecting = (session[:return_to]!=nil)
  end

  def home
  end

  def profile
  end

  def setting
  end

  def logout
    
    # Take the user out of the session
    session.delete :user_id

    # Redirect to the homepage
    redirect_to :controller => 'home', :action => 'index'

    # Set a flash message
    @messages.add_msg "You were successfully logged out"
    
  end
  
  def login_attempt
    authorized_user = User.authenticate( params[:name], params[:pwd])
    if authorized_user
      session[:user_id] = authorized_user.id
      @messages.add_msg "You successfully logged in"
      url = session[:return_to] || sessions_home_path
      session[:return_to] = nil
      url = root_path if url.eql?('/logout')
      redirect_to url
    else
      @messages.add_msg "Your credentials were bad - please try again", StreamsMsg::ERROR
      flush_messages
      render :action => "login"

    end

  end

end
