class AddAchievedAtToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :achieved_at, :date
  end
end
