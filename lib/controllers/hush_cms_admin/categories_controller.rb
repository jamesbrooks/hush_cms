class HushCmsAdmin::CategoriesController < HushCmsAdminController
  before_filter :find_categories
  before_filter :find_category, :except => [ :index, :new, :create ]
  
  
  def index
  end
  
  def show
  end
  
  def new
    @category = HushCMS::Category.new
  end
  
  def create
    @category = HushCMS::Category.new(params[:hush_cms_category])
    
    if @category.save
      redirect_to hush_cms_admin_category_posts_path(@category)
    else
      @category_errors = []
      @category.errors.each do |attribute, error|
        @category_errors << "'#{attribute.gsub(/["']/) { |m| "\\#{m}" }}': '#{error.gsub(/["']/) { |m| "\\#{m}" }}'"
      end
      
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @category.update_attributes(params[:hush_cms_category])
      redirect_to hush_cms_admin_categories_url
    else
      @category_errors = []
      @category.errors.each do |attribute, error|
        @category_errors << "'#{attribute.gsub(/["']/) { |m| "\\#{m}" }}': '#{error.gsub(/["']/) { |m| "\\#{m}" }}'"
      end
      
      render :action => 'edit'
    end
  end
  
  def destroy
    @category.destroy
    redirect_to :back
  end
  
  
private
  def find_categories
    @categories = HushCMS::Category.find(:all)
  end

  def find_category
    @category = HushCMS::Category.find(params[:id])
  end
end
