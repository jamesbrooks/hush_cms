module ProvidesPages
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def provides_pages(template='global/page')
      @hush_cms_page_template = template
      include ProvidesPages::InstanceMethods
    end
    
    def hush_cms_page_template
      @hush_cms_page_template || self.superclass.instance_variable_get('@hush_cms_page_template')
    end
  end
  
  module InstanceMethods
    def hush_cms_locate_page
      @hush_cms_page = HushCMS::Page.locate(params[:path])
      
      if @hush_cms_page && @hush_cms_page.published?
        render :template => self.class.hush_cms_page_template
      else
        render :file => "#{RAILS_ROOT}/public/404.html", :status => 404
      end
    end
  end
end
