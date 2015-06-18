class Workstream < ActiveRecord::Base
  belongs_to :parent, nil, { :class_name => "Workstream", :foreign_key => "parent_workstream_id" }
  has_many :children, nil, { :class_name => "Workstream", :foreign_key => "parent_workstream_id" }
  has_many :goals, nil, { :class_name => "Goal", :foreign_key => "workstream_id" }

  def self.root_collection
    return Workstream.where( parent: nil )
  end

  def root?
    return self.parent_workstream_id==nil
  end

  def parent?
    return self.children.count > 0
  end

end
