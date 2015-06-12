class CreateWorkstreams < ActiveRecord::Migration
  def change
    create_table :workstreams do |t|
      t.string :name
      t.string :type
      t.integer :parent_workstream_id

      t.timestamps null: false
    end
  end
end
