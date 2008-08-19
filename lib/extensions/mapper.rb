module ActionController
  module Routing
    class RouteSet
      class Mapper
        def hush_cms_pages(path, options = {})          
          named_route "hush_cms_page", path, :controller => 'hush_cms_pages', :action => 'show'
        end
      end
    end
  end
end
