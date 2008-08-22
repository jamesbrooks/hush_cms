module ActionController
  module Routing
    class RouteSet
      class Mapper
        def hush_cms_pages(path)
          named_route 'hush_cms_page', "#{path}/*path", :controller => 'hush_cms_pages', :action => 'show'
        end
        
        def hush_cms_posts(path, options={})
          post_component_order = options[:order] || [:category, :year, :month, :day, :slug ]
          
          named_route 'hush_cms_posts', "#{path}/:category/:format", :controller => 'hush_cms_posts', :action => 'index', :defaults => { :format => 'html' }
          named_route 'hush_cms_posts_page', "#{path}/:category/page/:page", :controller => 'hush_cms_posts', :action => 'index', :defaults => { :page => 1 }
          named_route 'hush_cms_post', "#{path}/#{post_component_order.map { |c| ":#{c}" }.join('/')}", :controller => 'hush_cms_posts', :action => 'show'
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
            a.resources :snippets
          end
        end
      end
    end
  end
end
