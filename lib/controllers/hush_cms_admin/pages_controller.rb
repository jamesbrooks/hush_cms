class HushCmsAdmin::PagesController < HushCmsAdminController
  before_filter :find_page, :only => [ :show, :edit, :update, :destroy ]
  
  
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
  
  
private
  def find_page
    @page = HushCMS::Page.find(params[:id])
  end
end
