class HushCmsPagesController < ApplicationController
  before_filter :find_page
  
  def show
  end
  

private
  def find_page
    @page = HushCMS::Page.locate(params[:path])
    render :file => "#{RAILS_ROOT}/public/404.html", :status => 404 unless @page && @page.published?
  end
end
