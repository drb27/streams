class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.date :target
      t.boolean :done
      t.integer :goal_id
      t.integer :successor_id

      t.timestamps null: false
    end
  end
end
