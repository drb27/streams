class GoalsController < ApplicationController

  def new
    @workstream = (Workstream.find_by_id params[:workstream_id]).becomes(Workstream)
    authorize @workstream, :modifygoals?
    @new_goal = Goal.new
    @new_goal.workstream = @workstream
  end

  def create
    newgoal = Goal.new goal_params
    newgoal.workstream_id = params[:workstream_id]
    authorize newgoal
    newgoal.save
    redirect_to newgoal.workstream
  end

  def destroy
    g = Goal.find_by_id params[:id]
    w = g.workstream.becomes(Workstream)
    authorize g
    g.delete

    respond_to do |format|
      format.html { redirect_to w }
      format.js
    end

  end
  
  def goal_params
    params.require(:goal).permit(:name,:target,:achieved)
  end

end
