class HushCmsAdminController < ApplicationController
  layout 'hush_cms_admin'
  before_filter :authenticate
  
  def index
  end
  

private
  def authenticate    
    authenticate_or_request_with_http_basic('Hush Administration') do |username, password|
      username == HushCMS.configuration['administration']['username'] && password == HushCMS.configuration['administration']['password']
    end
  end
end
