class AddGoalsIdToGoalcomments < ActiveRecord::Migration
  def change
    add_column :goalcomments, :goal_id, :integer
  end
end
