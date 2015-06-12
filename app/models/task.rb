class Task < ActiveRecord::Base
  belongs_to :goal
  belongs_to :successor, nil, {:class_name => "Task", :foreign_key => "successor_id" }
end
