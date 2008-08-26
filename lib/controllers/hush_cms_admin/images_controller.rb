class HushCmsAdmin::ImagesController < HushCmsAdminController
  before_filter :find_image, :except => [ :index, :new, :create ]
  
  
  def index
    @images = HushCMS::Image.find(:all, :order => 'name ASC')
  end
  
  def show
  end
  
  def new
    @image = HushCMS::Image.new
  end
  
  def create
    @image = HushCMS::Image.new(params[:hush_cms_image])
    
    if @image.save
      redirect_to hush_cms_admin_images_url
    else
      prepare_error_messages_for_javascript @image
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @image.update_attributes(params[:hush_cms_image])
      redirect_to hush_cms_admin_images_url
    else
      prepare_error_messages_for_javascript @image
      render :action => 'edit'
    end
  end
  
  def destroy
    @image.destroy
    redirect_to hush_cms_admin_images_url
  end
  
private
  def find_image
    @image = HushCMS::Image.find(params[:id])
  end
end
