class WorkstreamsController < ApplicationController
  def new
  end

  def create
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def show
    @workstream = (Workstream.find_by_id params[:id]).becomes(Workstream)
    raise ActionController::RoutingError.new('Not Found') unless @workstream
    authorize @workstream

    # Get a list of actions from the goals controller
    @actions = GoalsController.actions.keys
    @completedactions = GoalsController.completedactions.keys
  end

  def index
    @root_workstreams = Workstream.root_collection
    authorize @root_workstreams
  end

  
end
