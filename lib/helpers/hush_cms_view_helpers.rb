module HushCMSViewHelpers
  def hush_cms_snippet(slug)
    content_tag :div, :class => "snippet #{slug}-snippet" do
      HushCMS::Snippet.find_by_slug(slug).content rescue "('#{slug}' snippet not found)"
    end
  end
  
  def hush_cms_image(name)
    image_tag HushCMS::File.images.find_by_name(name).file.url, :alt => name, :class => "#{name.slugify}-image" rescue ''
  end
  
  def hush_cms_breadcrumbs(page)
    page.breadcrumbs.map do |page|
      link_to page.title, hush_cms_page_path(page.path)
    end.join(' &raquo; ')
  end
  
  def generate_hush_cms_post_path(post)
    hush_cms_post_location(:hush_cms_post_path, post)
  end
  
  def generate_hush_cms_post_url(post)
    hush_cms_post_location(:hush_cms_post_url, post)
  end
  
  def to_formatted_hush_time(time)
    time.to_s(time.min > 0 ? :hush_time : :hush_time_without_minutes).gsub(/^0/, '').downcase
  end
  
  
private
  def hush_cms_post_location(m, post)
    send m, {
      :category => post.category.slug,
      :year     => post.published_at.year,
      :month    => '%02d' % post.published_at.month,
      :day      => '%02d' % post.published_at.day,
      :slug     => post.slug      
    }
  end
end
