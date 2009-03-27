class HushCmsAdminController < ApplicationController
  layout 'hush_cms_admin'
  before_filter :authenticate
  helper :hush_cms_admin
  
  uses_tiny_mce(:options => {:theme => 'advanced',
    :theme_advanced_toolbar_location => "top",
    :theme_advanced_toolbar_align => "center",
    :theme_advanced_resizing => true,
    :theme_advanced_resize_horizontal => false,
    :paste_auto_cleanup_on_paste => true,
    :theme_advanced_blockformats => %w{h1 h2 h3},
    :theme_advanced_buttons1 => %w{code formatselect bold italic underline strikethrough separator justifyleft justifycenter justifyright indent outdent separator bullist numlist forecolor backcolor separator link unlink image},
    :theme_advanced_buttons2 => %w{tablecontrols},
    :theme_advanced_buttons3 => [],
    :plugins => %w{contextmenu paste table},
    :relative_urls => false,
    :external_image_list_url => ActionController::Routing::Routes.named_routes['images_hush_cms_admin_files'].segments.map(&:to_s).join.gsub(/:format/, 'js'),
    :external_link_list_url => ActionController::Routing::Routes.named_routes['non_images_hush_cms_admin_files'].segments.map(&:to_s).join.gsub(/:format/, 'js')},
    :only => [:new, :create, :edit, :update])
  
  
  def index
  end
    

protected
  def prepare_error_messages_for_javascript(obj)
    @js_model_with_errors = obj.class.table_name.singularize
    @js_model_errors = []
    
    obj.errors.each do |attribute, error|
      @js_model_errors << "'#{attribute.gsub(/["']/) { |m| "\\#{m}" }}': '#{error.gsub(/["']/) { |m| "\\#{m}" }}'"
    end
  end
  
  def chronisize(*attributes)
    if defined?(Chronic)
      attributes.each do |attribute|
        if attribute && chronisized_value = Chronic.parse(attribute)
          attribute.replace chronisized_value.to_s(:hush_time).gsub(/^0/, '').downcase
        end
      end
    end
  end

private
  def authenticate    
    authenticate_or_request_with_http_basic('Hush Administration') do |username, password|
      username == HushCMS.configuration['administration']['username'] && password == HushCMS.configuration['administration']['password']
    end
  end
end
