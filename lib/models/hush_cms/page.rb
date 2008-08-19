class HushCMS::Page < ActiveRecord::Base
  set_table_name 'hush_cms_pages'
  
  acts_as_list :scope => :parent_id
  
  belongs_to :parent, :class_name => 'HushCMS::Page', :foreign_key => 'parent_id'
  has_many :children, :class_name => 'HushCMS::Page', :foreign_key => 'parent_id'
  
  named_scope :published, :conditions => 'published_at IS NOT NULL'
  
  validates_presence_of :title, :slug
  validates_uniqueness_of :slug, :scope => :parent_id

  before_validation :assign_slug_if_absent
    
  
  def to_s
    title
  end
  
  def published?
    published_at
  end
  
  def publish!
    update_attribute :published_at, Time.now
  end
  
  def unpublish!
    update_attribute :published_at, nil
  end
  
  def breadcrumbs
    parent ? parent.breadcrumbs << self : [self]
  end
  
  def path
    breadcrumbs.map { |p| p.slug }.join('/')
  end
  
  def self.locate(path, parent=nil)
    page = parent ? parent.children.find_by_slug(path.shift) : find_by_slug(path.shift)
    path.empty? ? page : locate(path, page)
  end
  
  
private
  def assign_slug_if_absent
    if title?
      self.slug = title.slugify unless slug?
      assign_unique_slug if slug_taken?
    end
  end
  
  def assign_unique_slug(count=1)
    self.slug = "#{title.slugify}-#{count}"
    assign_unique_slug(count+1) if slug_taken?
  end
  
  def slug_taken?
    if new_record?
      HushCMS::Page.count(:conditions => [ 'slug = ? AND parent_id = ?', slug, parent_id ]) > 0
    else
      HushCMS::Page.count(:conditions => [ 'slug = ? AND parent_id = ? AND id != ?', slug, parent_id, id ]) > 0
    end
  end
end
