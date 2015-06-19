class GoalsController < ApplicationController

  def new
    @workstream = Workstream.find_by_id params[:workstream_id]
    @new_goal = Goal.new
    @new_goal.workstream = @workstream
  end

  def create
    newgoal = Goal.new goal_params
    newgoal.workstream_id = params[:workstream_id]
    newgoal.save
    redirect_to newgoal.workstream
  end

  def goal_params
    params.require(:goal).permit(:name)
  end

end
