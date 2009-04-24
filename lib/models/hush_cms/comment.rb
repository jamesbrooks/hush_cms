class HushCMS::Comment < ActiveRecord::Base
  set_table_name 'hush_cms_comments'
  
  belongs_to :post, :class_name => 'HushCMS::Post'
  
  named_scope :approved, :conditions => { :approved => true }
  named_scope :unapproved, :conditions => { :approved => false }  
  
  validates_presence_of :name, :email, :content
  
  attr_protected :approved
  
  
  def approve!
    update_attribute :approved, true
  end
  
  def unapprove!
    destroy
  end
end
