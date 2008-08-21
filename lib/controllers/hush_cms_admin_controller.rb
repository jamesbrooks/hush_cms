class HushCmsAdminController < ApplicationController
  layout 'hush_cms_admin'
  before_filter :authenticate
  
  uses_tiny_mce(:options => {:theme => 'advanced',
    :browsers => %w{msie gecko},
    :theme_advanced_toolbar_location => "top",
    :theme_advanced_toolbar_align => "center",
    :theme_advanced_resizing => true,
    :theme_advanced_resize_horizontal => false,
    :paste_auto_cleanup_on_paste => true,
    :theme_advanced_buttons1 => %w{fontsizeselect bold italic underline strikethrough separator justifyleft justifycenter justifyright indent outdent separator bullist numlist forecolor backcolor separator link unlink image undo redo},
    :theme_advanced_buttons2 => [],
    :theme_advanced_buttons3 => [],
    :plugins => %w{contextmenu paste}},
    :only => [:new, :create, :edit, :update])
  
  
  def index
  end
  

private
  def authenticate    
    authenticate_or_request_with_http_basic('Hush Administration') do |username, password|
      username == HushCMS.configuration['administration']['username'] && password == HushCMS.configuration['administration']['password']
    end
  end
end
