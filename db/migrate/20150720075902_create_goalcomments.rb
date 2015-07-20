class CreateGoalcomments < ActiveRecord::Migration
  def change
    create_table :goalcomments do |t|
      t.string :headline
      t.string :body

      t.timestamps null: false
    end
  end
end
