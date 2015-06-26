class WorkstreamApiController < ApplicationController

  def fetch
    w = (Workstream.find_by_id params[:id]).becomes Workstream
    authorize w
    render json: w
  end

end
