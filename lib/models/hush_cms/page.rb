class HushCMS::Page < ActiveRecord::Base
  set_table_name 'hush_cms_pages'
  
  acts_as_list :scope => :parent_id
  
  belongs_to :parent, :class_name => 'HushCMS::Page', :foreign_key => 'parent_id'
  has_many :children, :class_name => 'HushCMS::Page', :foreign_key => 'parent_id', :order => 'position ASC'
  has_many :snippets, :class_name => 'HushCMS::Snippet', :foreign_key => 'page_id'
  
  named_scope :published, :conditions => 'published_at IS NOT NULL', :order => 'position ASC'
  named_scope :children_of, lambda { |parent| { :conditions => { :parent_id => parent.id } } }
  
  validates_presence_of :title, :slug
  validates_uniqueness_of :slug, :scope => :parent_id

  before_validation :assign_slug
    
  
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
    update_attribute :published_at, Time.now
  end
  
  def unpublish!
    update_attribute :published_at, nil
  end
  
  def make_permanent!
    update_attribute :permanent, true
  end
  
  def make_unpermanent!
    update_attribute :permanent, false
  end
  
  def breadcrumbs
    @breadcrumbs ||= parent ? parent.breadcrumbs << self : [self]
  end
  
  def ancestors
    @ancestors ||= breadcrumbs.reverse[1..-1]
  end
  
  def root_ancestor
    breadcrumbs.first
  end
  
  def path
    @path ||= breadcrumbs.map { |p| p.slug }.join('/')
  end
  
  def possible_parents
    HushCMS::Page.all.map { |p| [ p.path, p.id ] }.reject { |p| p.first.starts_with? path }
  end
  
  def pages_for_redirect_to
    HushCMS::Page.find(:all, :conditions => [ 'id != ?', id ]).map { |p| [ p.path, p.id ] }
  end
  
  def snippet(slug, recurse=true)
    if s = snippets.find_by_slug(slug)
      s.content
    else
      recurse && parent ? parent.snippet(slug, recurse) : "('#{slug}' snippet not found)"
    end
  end
  
  def self.base_pages
    find_all_by_parent_id nil, :order => 'position ASC'
  end
  
  def self.locate(path, parent=nil)
    page = parent ? parent.children.find_by_slug(path.shift) : find_by_slug(path.shift)
    path.empty? ? page : locate(path, page)
  end  
  
  
private
  def assign_slug
    if title?
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
      HushCMS::Page.count(:conditions => [ 'slug = ? AND parent_id = ?', slug, parent_id ]) > 0
    else
      HushCMS::Page.count(:conditions => [ 'slug = ? AND parent_id = ? AND id != ?', slug, parent_id, id ]) > 0
    end
  end
end
