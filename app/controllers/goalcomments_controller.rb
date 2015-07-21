class GoalcommentsController < ApplicationController

  def create
    @goal = Goal.find_by_id params[:goal_id]
    @goalcomment = Goalcomment.new gc_params
    @goalcomment.user = @current_user
    @goalcomment.goal = @goal
    authorize @goalcomment

    if @goalcomment.save
      @messages.add_msg "Your comment was successfully created"
      redirect_to @goal
    else
      if @goalcomment.errors.any?
        @goalcomment.errors.full_messages.each do |message|
          @messages << { message: message, severity: StreamsMsg::ERROR }
        end
      else
        @messages << { message: "A problem occurred - your comment was not saved.", severity: StreamsMsg::ERROR }
      end
      flush_messages
      redirect_to @goal
    end
    
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

  def gc_params
    params.require(:goalcomment).permit(:user_id,:headline,:body,:goal_id)
  end

end
