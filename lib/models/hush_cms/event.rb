class HushCMS::Event < ActiveRecord::Base
  set_table_name 'hush_cms_events'
  
  belongs_to :calendar, :class_name => 'HushCMS::Calendar'
  
  named_scope :upcoming, lambda { { :conditions => [ 'start_date >= ?', Time.now ] } }
  
  validates_presence_of :calendar, :name, :details, :start_date, :finish_date
  validate :logical_time_bounds
  

private
  def logical_time_bounds
    if finish_date? && start_date?
      if finish_date < start_date
        errors.add(:finish_date, "can't be before start")
      elsif finish_date == start_date
        if start_time? && finish_time?
          if finish_time < start_time
            errors.add(:finish_time, "can't be before start")
          end
        end
      end
    end
  end
end
