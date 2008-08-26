class HushCMS::Image < ActiveRecord::Base
  set_table_name 'hush_cms_images'
  
  has_attached_file :image,
    :styles => { :thumb => "150x150#" }
    :path => ':rails_root/public/media/cms/:class/:id/:style_:filename'
    :url => '/media/cms/:class/:id/:style_:filename'
    
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_attachment_presence :image
end
