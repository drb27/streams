class AddUserToGoalComments < ActiveRecord::Migration
  def change
    add_column :goalcomments, :user_id, :integer
  end
end
