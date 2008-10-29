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
  
  def to_formatted_hush_time(time)
    time.to_s(time.min > 0 ? :hush_time : :hush_time_without_minutes).gsub(/^0/, '').downcase
  end
end
