class HomeController < ApplicationController
  def index
    @workstreams = Workstream.all
  end
end
