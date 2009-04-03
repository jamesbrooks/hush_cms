namespace :hush_cms do
  desc 'Updates application support files for HushCMS (images, stylesheets and javascripts)'
  task :update => :environment do
    require 'fileutils'
    
    hush_config      = "#{RAILS_ROOT}/config/hush.yml"
    hush_images      = "#{RAILS_ROOT}/public/images/hush_cms"
    hush_javascripts = "#{RAILS_ROOT}/public/javascripts/hush_cms_admin.js"
    hush_stylesheets = "#{RAILS_ROOT}/public/stylesheets/hush_cms_admin.css"
    date_javascripts = "#{RAILS_ROOT}/public/javascripts/hush_cms_date_picker.js"
    date_stylesheets = "#{RAILS_ROOT}/public/stylesheets/hush_cms_date_picker.css"
    date_languages   = "#{RAILS_ROOT}/public/javascripts/hush_cms_date_lang"
    
    FileUtils.rm_r hush_images if File.exist?(hush_images)
    FileUtils.rm_r hush_javascripts if File.exist?(hush_javascripts)
    FileUtils.rm_r hush_stylesheets if File.exist?(hush_stylesheets)
    FileUtils.rm_r date_javascripts if File.exist?(date_javascripts)
    FileUtils.rm_r date_stylesheets if File.exist?(date_stylesheets)
    FileUtils.rm_r date_languages if File.exist?(date_languages)    
    
    FileUtils.cp_r File.dirname(__FILE__) + '/../install/images',                               hush_images      unless File.exist?(hush_images)
    FileUtils.cp_r File.dirname(__FILE__) + '/../install/javascripts/hush_cms_admin.js',        hush_javascripts unless File.exist?(hush_javascripts)
    FileUtils.cp_r File.dirname(__FILE__) + '/../install/stylesheets/hush_cms_admin.css',       hush_stylesheets unless File.exist?(hush_stylesheets)
    FileUtils.cp_r File.dirname(__FILE__) + '/../install/javascripts/hush_cms_date_picker.js',  date_javascripts unless File.exist?(date_javascripts)
    FileUtils.cp_r File.dirname(__FILE__) + '/../install/stylesheets/hush_cms_date_picker.css', date_stylesheets unless File.exist?(date_stylesheets)
    FileUtils.cp_r File.dirname(__FILE__) + '/../install/javascripts/hush_cms_date_lang',       date_languages   unless File.exist?(date_languages)
    
    puts "\nHush CMS support files have been successfully updated."
  end
end
