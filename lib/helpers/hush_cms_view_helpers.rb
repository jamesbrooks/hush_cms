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
end
