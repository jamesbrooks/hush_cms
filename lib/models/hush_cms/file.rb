class HushCMS::File < ActiveRecord::Base  
  set_table_name 'hush_cms_files'
  
  named_scope :by_name, :order => 'name ASC'
  named_scope :images, :conditions => 'file_content_type LIKE "image/%"'
  named_scope :non_images, :conditions => 'file_content_type NOT LIKE "image/%"'
  
  has_attached_file :file,
    :styles => { :thumb => "100x100#" },
    :path => ':rails_root/public/media/cms/files/:id/:style.:extension',
    :url => '/media/cms/files/:id/:style.:extension'
    
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_attachment_presence :file
  
  
  def image?
    file_content_type.starts_with?('image/')
  end
  
  def extension
    File.extname(file_file_name).from(1)
  end
end
