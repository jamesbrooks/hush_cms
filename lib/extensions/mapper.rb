module ActionController
  module Routing
    class RouteSet
      class Mapper
        def hush_cms_pages(path)
          named_route 'hush_cms_page', "#{path}/*path", :controller => HushCMS.configuration['controllers']['pages'], :action => 'show'
        end
        
        def hush_cms_posts(path, options={})
          post_component_order = options[:order] || [ :category, :year, :month, :day, :slug ]
          
          named_route 'hush_cms_posts',
            "#{path}/:category/:page",
            :controller => HushCMS.configuration['controllers']['posts'],
            :action => 'index',
            :defaults => { :page => 1 },
            :requirements => { :page => /\d+/ }
          
          named_route 'hush_cms_formatted_posts',
            "#{path}/:category/:format",
            :controller => HushCMS.configuration['controllers']['posts'],
            :action => 'index',
            :defaults => { :format => 'html' },
            :requirements => { :format => /html|rss/ }          
            
          named_route 'hush_cms_month_posts',
            "#{path}/#{post_component_order.select { |c| [ :category, :year, :month ].include?(c) }.map { |c| ":#{c}" }.join('/')}",
            :controller => HushCMS.configuration['controllers']['posts'],
            :action => 'archive',
            :requirements => { :year => /\d+/, :month => /\d+/ }
            
          named_route 'hush_cms_post',
            "#{path}/#{post_component_order.map { |c| ":#{c}" }.join('/')}",
            :controller => HushCMS.configuration['controllers']['posts'],
            :action => 'show'
        end
        
        def hush_cms_admin(path)
          named_route 'hush_cms_admin', path, :controller => 'hush_cms_admin/pages', :action => 'index'
          
          namespace :hush_cms_admin, :path_prefix => path do |a|
            a.resources :categories do |c|
              c.resources :posts, :member => { :publish => :put, :unpublish => :put }
            end

            a.resources :pages, :member => { :publish => :put, :unpublish => :put, :move_higher => :put, :move_lower => :put } do |p|
              p.resources :snippets
            end
            
            a.resources :comments, :member => { :approve => :put, :unapprove => :put }
            a.resources :images
            a.resources :snippets
          end
        end
      end
    end
  end
end
