module ActionController
  module Routing
    class RouteSet
      class Mapper
        def hush_cms_pages(path, options = {})
          named_route 'hush_cms_page', path, :controller => 'hush_cms_pages', :action => 'show'
        end
        
        def hush_cms_admin(path)
          named_route 'hush_cms_admin', path, :controller => 'hush_cms_admin/pages', :action => 'index'
          
          namespace :hush_cms_admin, :path_prefix => path do |a|
            a.resources :categories do |c|
              c.resources :posts, :member => { :publish => :put, :unpublish => :put } do |p|
                p.resources :comments
              end
            end
            
            a.resources :pages, :member => { :publish => :put, :unpublish => :put, :move_higher => :put, :move_lower => :put }
          end
        end
      end
    end
  end
end
