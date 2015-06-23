class UsersController < ApplicationController

  before_filter :save_login_state, :only => [ :new, :create ]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.isadmin = false
    if @user.save
      flash[:notice] = "You signed up successfully"
      flash[:color] = "valid"
    else
      flash[:notice] = "Form is invalid"
      flash[:color] = "invalid"
    end
    render "new"
  end

  def user_params
    params.require(:user).permit(:name,:pwd,:isadmin)
  end
  
end
