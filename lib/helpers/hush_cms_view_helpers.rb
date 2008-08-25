module HushCMSViewHelpers
  def hush_cms_snippet(name)
    HushCMS::Snippet.find_by_name(name).content rescue "('#{name}' snippet not found)"    
  end
  
  def hush_cms_breadcrumbs(page)
    page.breadcrumbs.map do |page|
      link_to page.title, hush_cms_page_path(page.path)
    end.join(' &raquo; ')
  end
end
