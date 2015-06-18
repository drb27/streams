class GoalsController < ApplicationController

  def new
    @workstream = Workstream.find_by_id params[:workstream_id]
    @new_goal = Goal.new
    @new_goal.workstream = @workstream
  end

  def create
    newgoal = Goal.new params[:goal]
    newgoal.save
    redirect_to @workstream
  end

end
