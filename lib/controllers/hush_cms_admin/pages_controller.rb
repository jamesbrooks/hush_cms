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
    @parent = HushCMS::Page.find(params[:hush_cms_page][:parent]) if params[:hush_cms_page][:parent]
    @page = @parent ? @parent.children.build(params[:hush_cms_page]) : HushCMS::Page.new(params[:hush_cms_page])
    
    if @page.save
      redirect_to hush_cms_admin_page_url(@page)
    else
      @pages = HushCMS::Page.base_pages unless params[:hush_cms_page][:parent]

      @page_errors = []
      @page.errors.each do |attribute, error|
        @page_errors << "'#{attribute.gsub(/["']/) { |m| "\\#{m}" }}': '#{error.gsub(/["']/) { |m| "\\#{m}" }}'"
      end
      
      render :action => 'new'
    end
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
