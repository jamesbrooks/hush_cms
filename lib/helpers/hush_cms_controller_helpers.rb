module HushCMSControllerHelpers
  def hush_cms_posts_for(category, options={})
    HushCMS::Category.find_by_name(category).posts.published.all(options) rescue []
  end
end
