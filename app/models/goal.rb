class Goal < ActiveRecord::Base
  belongs_to :workstream
  has_many :task

  def ordered_tasks
    l=[]
    tasks = []
    self.task.each { |t| tasks.push t }
    while l.length < self.task.length
      
      tasks.each do |t|
        # if no successor, add to the end of the list
        if t.successor == nil
          # This is the tail, add to the end
          l.push(t)
        else
          # Try to find the successor in the list
          idx = l.find_index { |i| i.id==t.successor.id }
          l.insert(idx,t) unless idx==nil
        end  
      end
      
      # Remove all tasks from tasks that are in l
      l.each do |t|
        idx = tasks.find_index { |i| i.id==t.id }
        tasks.delete_at idx unless idx==nil
      end

    end
    return l
  end
  
end
