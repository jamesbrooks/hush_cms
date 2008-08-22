class HushCMS::Snippet < ActiveRecord::Base
  set_table_name 'hush_cms_snippets'
  
  validates_presence_of :name
  validates_uniqueness_of :name
end
