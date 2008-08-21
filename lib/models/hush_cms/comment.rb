class HushCMS::Comment < ActiveRecord::Base
  set_table_name 'hush_cms_comments'
  
  belongs_to :post
end
