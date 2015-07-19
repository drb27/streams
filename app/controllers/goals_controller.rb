class GoalsController < ApplicationController

  @actions = {
    :destroy => { :label => "Delete", :method => :delete, :remote => true, :controller => 'goals' },
    :edit => { :label => "Edit",  :method => :get, :controller => 'goals' },
    :complete => { :label => "Complete", :method => :get, :remote => true, :controller => 'goals' }
  }

  def self.actions
    return @actions
  end

  def new
    @workstream = (Workstream.find_by_id params[:workstream_id]).becomes(Workstream)
    authorize @workstream, :modifygoals?
    @goal = Goal.new
    @goal.workstream = @workstream
  end

  def show
    @goal = Goal.find params[:id]
    authorize @goal
  end
  
  def edit
    @goal = Goal.find params[:id]
    @workstream = @goal.workstream.becomes(Workstream)
    authorize @goal
  end

  def update
    
    @goal = Goal.find_by_id params[:id]
    @workstream = @goal.workstream
    authorize @goal

    if @goal.update goal_params

      # Update was successful
      @messages.add_msg "The goal was successfully updated"
      redirect_to @workstream

    else
      
      # Update failed
      if @goal.errors.any?
        @goal.errors.full_messages.each do |message|
          @messages << { message: message, severity: StreamsMsg::ERROR }
        end
      else
        @messages << { message: "A problem occurred - your goal was not saved.", severity: StreamsMsg::ERROR }  
      end
      flush_messages
      render :edit
    end

  end
  
  def create
    @workstream = (Workstream.find_by_id params[:workstream_id]).becomes(Workstream)
    @goal = Goal.new goal_params
    @goal.workstream = @workstream
    authorize @goal

    if @goal.save
      @messages.add_msg "Your goal was successfully created"
      redirect_to @goal.workstream
    else
      if @goal.errors.any?
        @goal.errors.full_messages.each do |message|
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
