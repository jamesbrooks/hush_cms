class HushCmsAdmin::PostsController < HushCmsAdminController
  before_filter :find_category
  before_filter :find_post, :except => [ :index, :new, :create ]
  
  
  def index
    @posts = @category.posts
  end
  
  def show
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
  def find_category
    @category = HushCMS::Category.find(params[:category_id])
  end

  def find_post
    @post = @category.posts.find(params[:id])
  end
end
