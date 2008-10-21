class HushCmsAdmin::ImagesController < HushCmsAdminController
  layout :decide_layout
  before_filter :find_image, :except => [ :index, :new, :create ]
  
  
  def index
    # Paginate with will_paginate if it's loaded
    paginate_method = if defined?(WillPaginate) && request.format != 'text/javascript'
      [ :paginate, { :per_page => 20, :page => params[:page] } ]
    else
      [ :all ]
    end
      @images = []
    # Include additional images if specified in configuration (images/additional) using eval
    if HushCMS.configuration['images'] && HushCMS.configuration['images']['additional']
      @images << ["Hush Images", HushCMS::Image.by_name.send(*paginate_method).map { |i| [ i.name, i.image.url ] }]
      @images += eval(HushCMS.configuration['images']['additional'])
      
      ims = []
      @images.map {|cat, imgs|        
        ims << ["===#{cat.capitalize}===", ""]
        imgs.map {|name, url|
          ims << [name.capitalize, url]
        }
        ims << [ "" , "" ]
      }

      @images = ims
    else
      @images = [HushCMS::Image.by_name.send(*paginate_method).map { |i| [ i.name, i.image.url ] }]
    end
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
  
  def decide_layout
    request.format == 'text/javascript' ? false : 'hush_cms_admin'
  end
end
