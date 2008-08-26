module HushCMSViewHelpers
  def hush_cms_snippet(name)
    content_tag :div, :class => "snippet #{name.slugify}-snippet" do
      HushCMS::Snippet.find_by_name(name).content rescue "('#{name}' snippet not found)"
    end
  end
  
  def hush_cms_breadcrumbs(page)
    page.breadcrumbs.map do |page|
      link_to page.title, hush_cms_page_path(page.path)
    end.join(' &raquo; ')
  end
end
