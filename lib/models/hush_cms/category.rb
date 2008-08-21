class HushCMS::Category < ActiveRecord::Base
  set_table_name 'hush_cms_categories'
  
  has_many :posts
  
  validates_presence_of :name, :slug
  validates_uniqueness_of :slug
  
  before_validation :assign_slug
  
  
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
