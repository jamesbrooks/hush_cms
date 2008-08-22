class HushCMS::Category < ActiveRecord::Base
  set_table_name 'hush_cms_categories'
  
  has_many :posts, :class_name => 'HushCMS::Post', :dependent => :destroy, :order => 'published_at DESC'
  
  validates_presence_of :name, :slug
  validates_uniqueness_of :slug
  
  before_validation :assign_slug
  
  def to_s
    name
  end
  
  def to_param
    [id, name].join(' ').slugify
  end
  
  def self.any_with_comments?
    count(:conditions => { :has_comments => true }) > 0
  end
  
  
private
  def assign_slug
    if name?
      self.slug = name.slugify
      assign_unique_slug if slug_taken?
    end
  end
  
  def assign_unique_slug(count=1)
    self.slug = "#{name.slugify}-#{count}"
    assign_unique_slug(count+1) if slug_taken?
  end
  
  def slug_taken?
    if new_record?
      HushCMS::Category.count(:conditions => [ 'slug = ?', slug ]) > 0
    else                                                 
      HushCMS::Category.count(:conditions => [ 'slug = ? AND id != ?', slug, id ]) > 0
    end
  end
end
