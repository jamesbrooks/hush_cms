class HushCmsAdmin::PagesController < HushCmsAdminController
  before_filter :find_page, :except => [ :index, :new, :create ]
  
  
  def index
    @pages = HushCMS::Page.base_pages
  end
  
  def show
  end
  
  def new
    @page = HushCMS::Page.new
    
    if params[:parent]
      @parent = HushCMS::Page.find(params[:parent])
    else
      @pages = HushCMS::Page.base_pages
    end
  end
  
  def create  
    if parent_id = params[:hush_cms_page].delete(:parent_page)
      @parent = HushCMS::Page.find(parent_id)
    end
    
    @page = @parent ? @parent.children.build(params[:hush_cms_page]) : HushCMS::Page.new(params[:hush_cms_page])
    
    if @page.save
      redirect_to hush_cms_admin_page_url(@page)
    else
      @pages = HushCMS::Page.base_pages unless @parent
      
      prepare_error_messages_for_javascript @page
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @page.update_attributes(params[:hush_cms_page])
      redirect_to hush_cms_admin_page_url(@page)
    else
      prepare_error_messages_for_javascript @page      
      render :action => 'edit'
    end
  end
  
  def destroy
    if @page.permanent?
      redirect_to :back
    else
      @page.destroy
      redirect_to @page.parent ? hush_cms_admin_page_url(@page.parent) : hush_cms_admin_pages_url
    end
  end
  
  def publish
    @page.publish! if @page.permanent?
    redirect_to hush_cms_admin_page_url(@page)
  end
  
  def unpublish
    @page.unpublish! if @page.permanent?
    redirect_to hush_cms_admin_page_url(@page)
  end
  
  def move_higher
    @page.move_higher
    redirect_to :back
  end
  
  def move_lower
    @page.move_lower
    redirect_to :back
  end
  
  
private
  def find_page
    @page = HushCMS::Page.find(params[:id])
  end
end
