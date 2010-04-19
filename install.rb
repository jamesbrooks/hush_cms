RAILS_ROOT = File.dirname(__FILE__) + "/../../../"
require 'fileutils'
 
hush_config      = "#{RAILS_ROOT}/config/hush.yml"
hush_images      = "#{RAILS_ROOT}/public/images/hush_cms"
hush_javascripts = "#{RAILS_ROOT}/public/javascripts/hush_cms_admin.js"
hush_stylesheets = "#{RAILS_ROOT}/public/stylesheets/hush_cms_admin.css"
date_javascripts = "#{RAILS_ROOT}/public/javascripts/hush_cms_date_picker.js"
date_stylesheets = "#{RAILS_ROOT}/public/stylesheets/hush_cms_date_picker.css"
date_languages   = "#{RAILS_ROOT}/public/javascripts/hush_cms_date_lang"

FileUtils.cp   File.dirname(__FILE__) + '/install/hush.yml.tpl',                         hush_config      unless File.exist?(hush_config)
FileUtils.cp_r File.dirname(__FILE__) + '/install/images',                               hush_images      unless File.exist?(hush_images)
FileUtils.cp_r File.dirname(__FILE__) + '/install/javascripts/hush_cms_admin.js',        hush_javascripts unless File.exist?(hush_javascripts)
FileUtils.cp_r File.dirname(__FILE__) + '/install/stylesheets/hush_cms_admin.css',       hush_stylesheets unless File.exist?(hush_stylesheets)
FileUtils.cp_r File.dirname(__FILE__) + '/install/javascripts/hush_cms_date_picker.js',  date_javascripts unless File.exist?(date_javascripts)
FileUtils.cp_r File.dirname(__FILE__) + '/install/stylesheets/hush_cms_date_picker.css', date_stylesheets unless File.exist?(date_stylesheets)
FileUtils.cp_r File.dirname(__FILE__) + '/install/javascripts/hush_cms_date_lang',       date_languages   unless File.exist?(date_languages)
FileUtils.cp_r File.dirname(__FILE__) + '/install/stylesheets/hush_cms_admin_navigation.css', nav_stylesheets unless File.exist?(nav_stylesheets)
FileUtils.cp_r File.dirname(__FILE__) + '/install/stylesheets/hush_cms_ie_admin.css', ie_stylesheets unless File.exist?(ie_stylesheets)

puts IO.read(File.join(File.dirname(__FILE__), 'install', 'INSTRUCTIONS'))
