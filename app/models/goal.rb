class Goal < ActiveRecord::Base

  belongs_to :workstream
  has_many :task
  has_many :goalcomment
  
  after_initialize :default_values

  def validate_workstream_id
    errors.add( :workstream_id, "is not a valid workstream") unless Workstream.exists?(self.workstream_id)
  end

  def validate_goal_is_in_future
    if self.new_record?
      errors.add( :target, "is not in the future") unless self.target && (self.target >= Date.today)
    else
      errors.add( :target, "is before the creation date (#{self.created_at.to_date})") unless self.target && (self.target >= self.created_at.to_date)
    end
  end

  validates :name, :presence => true, :length => { :in => 3..128 }
  validates :achieved, inclusion: [true,false]
  validate :validate_workstream_id
  validate :validate_goal_is_in_future
  validates :target, :presence => true # TODO: Validate date properly

  before_update :set_achieved_date, :if => :achieved_changed?

  def set_achieved_date
    if self.achieved
      self.achieved_at = Date.today
    end
  end
  
  def due_days
    return (self.target - Date.today).to_i
  end

  def percentage_time
    days = (self.target - self.created_at.to_date).to_i
    days_in = (Date.today - self.created_at.to_date).to_i

    if days == 0
      days=1
    end
    return days_in * 100 / days
  end

  def late?
    self.due_days < 0
  end
  
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

  private

  def default_values

    if self.new_record?
      self.achieved ||= false
    end
    
  end
  
end
