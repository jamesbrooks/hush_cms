class HushCmsAdmin::PagesController < HushCmsAdminController
  before_filter :find_page, :except => [ :index, :new, :create ]
  
  
  def index
    @pages = HushCMS::Page.base_pages
  end
  
  def show
    @children = @page.children
  end
  
  def new
  end
  
  def create
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  def publish
    @page.publish!
    redirect_to hush_cms_admin_page_url(@page)
  end
  
  def unpublish
    @page.unpublish!
    redirect_to hush_cms_admin_page_url(@page)
  end
  
  
private
  def find_page
    @page = HushCMS::Page.find(params[:id])
  end
end
