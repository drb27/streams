class GoalcommentsController < ApplicationController
  def create
  end

  def new
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def api_table
    @goal = Goal.find_by_id params[:id]
    @divname = "goalcomments"
    @comments = @goal.goalcomment
    respond_to do |format|
      format.js
    end
  end
end
