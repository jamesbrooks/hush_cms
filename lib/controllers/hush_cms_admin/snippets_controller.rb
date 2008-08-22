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
    @snippet = HushCMS::Snippet.new(params[:hush_cms_snippet])
    
    if @snippet.save
      redirect_to hush_cms_admin_snippets_url
    else
      prepare_error_messages_for_javascript @snippet
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @snippet.update_attributes(params[:hush_cms_snippet])
      redirect_to hush_cms_admin_snippets_url
    else
      prepare_error_messages_for_javascript @snippet
      render :action => 'edit'
    end
  end
  
  def destroy
    @snippet.destroy
    redirect_to :back
  end
  
  
private
  def find_snippets
    @snippets = HushCMS::Snippet.find(:all, :order => 'name DESC')
  end

  def find_snippet
    @snippet = HushCMS::Snippet.find(params[:id])
  end
end
