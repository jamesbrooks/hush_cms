module HushCMSControllerHelpers
  def hush_cms_posts_for(category, options={})
    HushCMS::Category.find_by_slug(category).posts.published.all(options) rescue []
  end
end
