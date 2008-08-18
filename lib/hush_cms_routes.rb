module ActionController
  module Routing
    class RouteSet
      class Mapper
        def hush_cms_pages(path, options = {})          
          named_route "hush_cms_page", path, :controller => 'application', :action => 'hush_cms_locate_page'
        end
      end
    end
  end
end
