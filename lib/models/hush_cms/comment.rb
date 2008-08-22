class HushCMS::Comment < ActiveRecord::Base
  set_table_name 'hush_cms_comments'
  
  belongs_to :post
  
  named_scope :approved, :conditions => { :approved => true }
  named_scope :unapproved, :conditions => { :approved => false }  
  
  validates_presence_of :name, :email, :content
end
