class HushCmsAdmin::FilesController < HushCmsAdminController
  layout :decide_layout
  before_filter :find_file, :except => [ :index, :images, :non_images, :new, :create ]
  
  
  def index
    # Paginate with will_paginate if it's loaded
    paginate_method = if defined?(WillPaginate)
      [ :paginate, { :per_page => 20, :page => params[:page] } ]
    else
      [ :all ]
    end
    
    @files = HushCMS::File.by_name.send(*paginate_method)
  end
  
  def images
    @files = []
    
    if HushCMS.configuration['images'] && HushCMS.configuration['images']['additional']
      @files << ["Hush Images", HushCMS::File.images.by_name.map { |i| [ i.name, i.file.url ] }]
      @files += eval(HushCMS.configuration['images']['additional'])
      
      ims = []
      @files.map {|cat, imgs|        
        ims << ["===#{cat.capitalize}===", ""]
        imgs.map {|name, url|
          ims << [name.capitalize, url]
        }
        ims << [ "" , "" ]
      }
    
      @files = ims
    else
      @files = HushCMS::File.images.by_name.map { |i| [ i.name, i.file.url ] }
    end
  end
  
  def non_images
    @files = HushCMS::File.non_images.by_name.map { |i| [ "#{i.name} (#{i.extension})", i.file.url ] }
  end
  
  def show
  end
  
  def new
    @file = HushCMS::File.new
  end
  
  def create
    @file = HushCMS::File.new(params[:hush_cms_file])
    
    if @file.save
      # TODO: Abstract this functionality out into HushCMS::File and the hush configuration
      if params[:resize]
        @file.file.instance_variable_set(:@styles, @file.file.styles.merge({:original => {:geometry => '500x2000>', :processors => 'thumbnail'}}))
        @file.file.reprocess!
      end

      redirect_to hush_cms_admin_files_url
    else
      prepare_error_messages_for_javascript @file
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @file.update_attributes(params[:hush_cms_file])
      redirect_to hush_cms_admin_files_url
    else
      prepare_error_messages_for_javascript @file
      render :action => 'edit'
    end
  end
  
  def destroy
    @file.destroy
    redirect_to hush_cms_admin_files_url
  end
  
private
  def find_file
    @file = HushCMS::File.find(params[:id])
  end
  
  def decide_layout
    request.format == 'text/javascript' ? false : 'hush_cms_admin'
  end
end
