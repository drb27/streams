class AddColorToWorkstream < ActiveRecord::Migration
  def change
    add_column :workstreams, :color, :string
  end
end
