class HushCmsAdmin::AuthenticationController < HushCmsAdminController
  layout 'hush_cms_admin_authentication'
  skip_before_filter :authenticate
  
  def login
    if params['authentication'] && params['authentication']['username'] && params['authentication']['password']
      if params['authentication']['username'] == HushCMS.configuration['administration']['username'] && params['authentication']['password'] == HushCMS.configuration['administration']['password']
        session[:is_hush_cms_admin] = true
        redirect_to hush_cms_admin_url
      else
        flash.now[:message] = 'Invalid username and password.'
      end
    end
  end
  
  def logout
    session[:is_hush_cms_admin] = false
    redirect_to hush_cms_admin_login_url
  end
end
