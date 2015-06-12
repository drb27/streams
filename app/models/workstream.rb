class Workstream < ActiveRecord::Base
  belongs_to :parent, nil, { :class_name => "Workstream", :foreign_key => "parent_workstream_id" }
  has_many :children, nil, { :class_name => "Workstream", :foreign_key => "parent_workstream_id" }
  has_many :goal
end
