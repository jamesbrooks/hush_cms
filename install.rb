require 'fileutils'
 
hush_config = File.dirname(__FILE__) + '/../../../config/hush.yml'
FileUtils.cp File.dirname(__FILE__) + '/install/hush.yml.tpl', hush_config unless File.exist?(hush_config)
puts IO.read(File.join(File.dirname(__FILE__), 'install', 'INSTRUCTIONS'))
