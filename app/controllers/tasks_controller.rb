class TasksController < ApplicationController

  def show
    @task = Task.find_by_id params[:id]
    authorize @task
  end
end
