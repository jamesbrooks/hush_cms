class HushCmsAdmin::PostsController < HushCmsAdminController
  before_filter :find_post_category
  before_filter :find_post, :except => [ :index, :new, :create ]
  
  
  def index
  end
  
  def show
  end
  
  def new
    @post = HushCMS::Post.new
  end
  
  def create
    @post = @post_category.posts.build(params[:hush_cms_post])
    
    if @post.save
      redirect_to hush_cms_admin_post_category_post_url(@post_category, @post)
    else
      prepare_error_messages_for_javascript @post      
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @post.update_attributes(params[:hush_cms_post])
      redirect_to hush_cms_admin_post_category_post_url(@post_category, @post)
    else
      prepare_error_messages_for_javascript @post
      render :action => 'edit'
    end
  end
  
  def destroy
    @post.destroy
    redirect_to hush_cms_admin_post_category_posts_url(@post_category)
  end
  
  def publish
    @post.publish!
    redirect_to :back
  end
  
  def unpublish
    @post.unpublish!
    redirect_to :back
  end
  
  
private
  def find_post_category
    @post_category = HushCMS::PostCategory.find(params[:post_category_id])
    @posts = @post_category.posts.all(:order => 'created_at DESC')
  end

  def find_post
    @post = @post_category.posts.find(params[:id])
  end
end
