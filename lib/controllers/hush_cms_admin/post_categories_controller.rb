class HushCmsAdmin::PostCategoriesController < HushCmsAdminController
  before_filter :find_post_categories
  before_filter :find_post_category, :except => [ :index, :new, :create ]
  
  
  def index
  end
  
  def show
  end
  
  def new
    @post_category = HushCMS::PostCategory.new
  end
  
  def create
    @post_category = HushCMS::PostCategory.new(params[:hush_cms_post_category])
    
    if @post_category.save
      redirect_to hush_cms_admin_post_category_posts_path(@post_category)
    else
      prepare_error_messages_for_javascript @post_category
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @post_category.update_attributes(params[:hush_cms_post_category])
      redirect_to hush_cms_admin_post_category_posts_path(@post_category)
    else
      prepare_error_messages_for_javascript @post_category
      render :action => 'edit'
    end
  end
  
  def destroy
    @post_category.destroy
    redirect_to hush_cms_admin_post_categories_path
  end
  
  
private
  def find_post_categories
    @post_categories = HushCMS::PostCategory.find(:all)
  end

  def find_post_category
    @post_category = HushCMS::PostCategory.find(params[:id])
  end
end
