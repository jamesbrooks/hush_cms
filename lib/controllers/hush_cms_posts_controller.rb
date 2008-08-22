class HushCmsPostsController < ApplicationController
  before_filter :find_category
  before_filter :find_post, :only => :show
  
  def index
  end
  
  def show
  end
  

private
  def find_category
    @category = HushCMS::Category.find_by_slug(params[:category])
    render :file => "#{RAILS_ROOT}/public/404.html", :status => 404 unless @category
  end
  
  def find_post
    published_at = Date.parse([params[:year], params[:month], params[:day]].join('-'))
    @post = @category.posts.published.find(:first, :conditions => [ 'slug = ? AND DATE(published_at) = ?', params[:slug], published_at ])
    
    redirect_to hush_cms_posts_url(@category.slug)
  end
end
