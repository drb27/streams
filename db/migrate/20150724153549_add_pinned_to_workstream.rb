class AddPinnedToWorkstream < ActiveRecord::Migration
  def change
    add_column :workstreams, :pinned, :bool
  end
end
