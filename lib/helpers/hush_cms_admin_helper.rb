module HushCmsAdminHelper
  def title
    @title
  end
  
  def title(title)
    @title = title
  end
  
  def add_link(url, type=:link)
    @links ? @links << [type, url] : @links = [[type, url]]
  end
end
