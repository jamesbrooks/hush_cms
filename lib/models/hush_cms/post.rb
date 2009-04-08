class HushCMS::Post < ActiveRecord::Base
  set_table_name 'hush_cms_posts'
  
  belongs_to :category, :class_name => 'HushCMS::PostCategory', :foreign_key => 'post_category_id'
  has_many :comments, :class_name => 'HushCMS::Comment', :dependent => :destroy
  
  named_scope :published, :conditions => 'published_at IS NOT NULL'
  named_scope :unpublished, :conditions => 'published_at IS NULL'
  named_scope :by_year_and_month, lambda { |year, month| {
    :conditions => [ 'YEAR(published_at) = ? AND MONTH(published_at) = ?', year, month]
  } }
  
  validates_presence_of :title, :author, :category
  validates_presence_of :slug, :if => :published?
  
  before_validation :assign_slug_if_published
  
  
  def to_s
    title
  end
  
  def to_param
    [id, title].join(' ').slugify
  end
  
  def published?
    published_at
  end
  
  def publish!
    self.published_at = Time.now
    save
  end
  
  def unpublish!
    update_attribute :published_at, nil
  end
  
  def self.archives(options={})
    all({
      :select => 'YEAR(published_at) as year, MONTH(published_at) as month, COUNT(*) as count',
      :conditions => 'published_at IS NOT NULL',
      :group => 'year, month',
      :order => 'year DESC, month DESC'}.merge(options)
    ).inject([]) { |c, g| c << { :year => g.year, :month => g.month, :count => g.count } }
  end
  
  
private
  def assign_slug_if_published
    if title? && published?
      self.slug = title.slugify
      assign_unique_slug if slug_taken?
    end
  end
  
  def assign_unique_slug(count=1)
    self.slug = "#{title.slugify}-#{count}"
    assign_unique_slug(count+1) if slug_taken?
  end
  
  def slug_taken?
    if new_record?
      HushCMS::Post.count(:conditions => [ 'slug = ? AND DATE(published_at) = ?', slug, published_at.to_date ]) > 0
    else
      HushCMS::Post.count(:conditions => [ 'slug = ? AND DATE(published_at) = ? AND id != ?', slug, published_at.to_date, id ]) > 0
    end
  end
end
