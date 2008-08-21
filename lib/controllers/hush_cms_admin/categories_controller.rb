class HushCmsAdmin::CategoriesController < HushCmsAdminController
  before_filter :find_category, :except => [ :index, :new, :create ]
  
  
  def index
    @categories = HushCMS::Category.find(:all)
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
    @category = HushCMS::Category.find(params[:id])
  end
end
