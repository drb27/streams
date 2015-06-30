class GoalsController < ApplicationController

  @actions = {
    :destroy => { :label => "Delete", :method => :delete, :remote => true, :controller => 'goals' },
    :edit => { :label => "Edit", :method => :edit, :controller => 'goals' },
    :complete => { :label => "Complete", :method => :get, :remote => true, :controller => 'goals' }
  }

  def self.actions
    return @actions
  end

  def new
    @workstream = (Workstream.find_by_id params[:workstream_id]).becomes(Workstream)
    authorize @workstream, :modifygoals?
    @new_goal = Goal.new
    @new_goal.workstream = @workstream
  end

  def create
    @workstream = (Workstream.find_by_id params[:workstream_id]).becomes(Workstream)
    @new_goal = Goal.new goal_params
    @new_goal.workstream = @workstream
    authorize @new_goal

    if @new_goal.save
      @messages.add_msg "Your goal was successfully created"
      redirect_to @new_goal.workstream
    else
      if @new_goal.errors.any?
        @new_goal.errors.full_messages.each do |message|
          @messages << { message: message, severity: StreamsMsg::ERROR }
        end
      else
        @messages << { message: "A problem occurred - your goal was not saved.", severity: StreamsMsg::ERROR }
      end
      flush_messages
      render action: "new"
    end
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

  def complete
    g=Goal.find_by_id params[:id]
    @w = g.workstream.becomes(Workstream)
    @acs = GoalsController.actions.keys
    @divname = "goalslist"
    authorize g
    g.achieved=true
    g.save
    @gls = @w.ordered_goals.select { |g| !g.achieved }

    respond_to do |format|
      format.html  { redirect_to g.workstream }
      format.js { render action: "api_table" } 
    end
  end

  def api_table
    @w = Workstream.find_by_id params[:id]
    @gls = @w.ordered_goals.select { |g| !g.achieved }
    @acs = GoalsController.actions.keys
    @divname = "goalslist"
    respond_to do |format|
      format.html { render partial:"goal_table", locals: { gls: @gls,
                                                           acs: @als,
                                                           id: @w.id } }
      format.js
    end

  end
  
  def goal_params
    params.require(:goal).permit(:name,:target,:achieved)
  end

end
