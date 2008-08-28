class HushCMS::Snippet < ActiveRecord::Base
  set_table_name 'hush_cms_snippets'

  belongs_to :page, :class_name => 'HushCMS::Page', :foreign_key => 'page_id'
  
  validates_presence_of :name, :slug
  validates_uniqueness_of :name, :scope => :page_id
  validates_uniqueness_of :slug, :scope => :page_id  

  before_validation :assign_slug
  
  
private
  def assign_slug
    self.slug = name.slugify
  end
end
