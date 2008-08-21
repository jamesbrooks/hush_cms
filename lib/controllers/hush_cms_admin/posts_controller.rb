class HushCmsAdmin::PostsController < HushCmsAdminController
  before_filter :find_post, :except => [ :index, :new, :create ]
  
  
  def index
    @posts = HushCMS::Post.find(:all)
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
  def find_post
    @post = HushCMS::Post.find(params[:id])
  end
end
