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

  end

  def index
    @root_workstreams = Workstream.root_collection
    authorize @root_workstreams
  end

  def tag_link_to sym,g
    atrb = GoalsController.actions[sym]
    atrb[:id] = g.id
    return view_context.link_to atrb[:label], {:id => atrb[:id], :controller => atrb[:controller], :action => sym}, :remote => atrb[:remote], :method => atrb[:method]
  end
  
  helper_method :tag_link_to  

end
