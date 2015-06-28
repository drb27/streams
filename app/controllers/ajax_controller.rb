class AjaxController < ApplicationController

  def dispatch_action

    # Dispatches a response to the caller to confirm
    # correct AJAX operation

    respond_to do |format|
      format.html { redirect_to :controller => 'sessions', :action => 'denied' }
      format.js
    end
  end

end
