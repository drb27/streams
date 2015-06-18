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
    @workstream = Workstream.find_by_id params[:id]
  end

  def index
    @root_workstreams = Workstream.root_collection
  end
end
