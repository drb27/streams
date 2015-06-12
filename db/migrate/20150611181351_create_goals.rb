class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :name
      t.date :target
      t.boolean :acheived
      t.integer :workstream_id

      t.timestamps null: false
    end
  end
end
