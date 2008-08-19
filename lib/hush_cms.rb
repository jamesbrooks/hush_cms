require 'extensions/string'
require 'extensions/mapper'

%w( models controllers helpers ).each do |dir|
  path = File.join(File.dirname(__FILE__), dir)
  $LOAD_PATH << path
  Dependencies.load_paths << path
  Dependencies.load_once_paths.delete(path)
end

ActionController::Base.append_view_path(File.join(File.dirname(__FILE__), 'views'))
ActionView::Base.send :include, HushCMSViewHelpers

module HushCMS
end
