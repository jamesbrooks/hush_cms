module HushCMSViewHelpers
  def hush_cms_snippet(slug)
    content_tag :div, :class => "snippet #{slug}-snippet" do
      HushCMS::Snippet.find_by_slug(slug).content rescue "('#{slug}' snippet not found)"
    end
  end
  
  def hush_cms_image(name)
    image_tag HushCMS::Image.find_by_name(name).image.url, :alt => name, :class => "#{name.slugify}-image" rescue ''
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
  
  
private
  def hush_cms_post_location(m, post)
    send m, {
      :category => post.category.slug,
      :year     => post.published_at.year,
      :month    => post.published_at.month,
      :day      => post.published_at.day,
      :slug     => post.slug      
    }
  end
end
