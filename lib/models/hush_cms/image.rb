class HushCMS::Image < ActiveRecord::Base
  set_table_name 'hush_cms_images'
  
  named_scope :by_name, :order => 'name ASC'
  
  has_attached_file :image,
    :styles => { :thumb => "100x100#" },
    :path => ':rails_root/public/media/cms/:class/:id/:basename_:style.:extension',
    :url => '/media/cms/:class/:id/:basename_:style.:extension'
    
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_attachment_presence :image
end
