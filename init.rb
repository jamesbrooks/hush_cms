require 'hush_cms'

ActionController::Base.class_eval do
  include ProvidesPages
end
