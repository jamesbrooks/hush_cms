module ActionController
  module Routing
    class RouteSet
      class Mapper
        def hush_cms_pages(path, options = {})
          options[:name_prefix] = 'cms_'
          
          named_route "#{options[:name_prefix]}page", path, :controller => 'application', :action => 'hush_cms_locate_page'
        end
      end
    end
  end
end
