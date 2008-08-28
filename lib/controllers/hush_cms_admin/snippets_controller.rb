class HushCmsAdmin::SnippetsController < HushCmsAdminController
  before_filter :find_snippets
  before_filter :find_snippet, :except => [ :index, :new, :create ]
  
  
  def index
  end
  
  def show
  end
  
  def new
    @snippet = HushCMS::Snippet.new
  end
  
  def create
    @snippet = @page ? @page.snippets.build(params[:hush_cms_snippet]) : HushCMS::Snippet.new(params[:hush_cms_snippet])
    
    if @snippet.save
      redirect_to @page ? hush_cms_admin_page_snippets_url(@page) : hush_cms_admin_snippets_url
    else
      prepare_error_messages_for_javascript @snippet
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @snippet.update_attributes(params[:hush_cms_snippet])
      redirect_to @page ? hush_cms_admin_page_snippets_url(@page) : hush_cms_admin_snippets_url
    else
      prepare_error_messages_for_javascript @snippet
      render :action => 'edit'
    end
  end
  
  def destroy
    @snippet.destroy
    redirect_to @page ? hush_cms_admin_page_snippets_url(@page) : :back
  end
  
  
private
  def find_snippets
    if params[:page_id]
      @page = HushCMS::Page.find(params[:page_id])
      @snippets = @page.snippets
    else
      @snippets = HushCMS::Snippet.find_all_by_page_id(nil, :order => 'name DESC')
    end
  end

  def find_snippet
    @snippet = @page ? @page.snippets.find(params[:id]) : HushCMS::Snippet.find_by_id_and_page_id(params[:id], nil)
  end
end
