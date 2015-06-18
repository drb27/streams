class HomeController < ApplicationController
  def index
    @workstreams = Workstream.root_collection
  end
end
