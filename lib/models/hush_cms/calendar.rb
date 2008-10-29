class HushCMS::Calendar < ActiveRecord::Base
  set_table_name 'hush_cms_calendars'
  
  has_many :events, :class_name => 'HushCMS::Event', :order => 'start_date ASC, start_time ASC'
  
  validates_presence_of :name, :slug
  validates_uniqueness_of :name, :slug
  
  before_validation :assign_slug
  
  
private
  def assign_slug
    self.slug = name.slugify if name?
  end
end
