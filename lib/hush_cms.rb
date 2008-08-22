# Load HAML
require 'haml'
if defined?(Haml)
  Haml.init_rails(binding)
else
  raise Exception.new("Hush CMS requires 'haml' to be installed:  gem install haml")
end

# Load will_paginate if possible
require 'will_paginate'

require 'extensions/string'
require 'extensions/mapper'
require 'extensions/acts_as_list'


module HushCMS
  class << self
    attr_accessor :configuration
    
    def load
      %w( models controllers controllers/admin helpers ).each do |dir|
        path = File.join(File.dirname(__FILE__), dir)
        $LOAD_PATH << path
        Dependencies.load_paths << path
        Dependencies.load_once_paths.delete(path)
      end

      ActiveRecord::Base.class_eval { include ActiveRecord::Acts::List }
      ActionController::Base.append_view_path(File.join(File.dirname(__FILE__), 'views'))
      ActionView::Base.send :include, HushCMSViewHelpers
      
      if File.exist?("#{RAILS_ROOT}/config/hush.yml")
        @configuration = YAML::load(File.open("#{RAILS_ROOT}/config/hush.yml"))
      else
        raise ConfigurationException.new("config/hush.yml doesn't exist")
      end
      
      ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge! :hush_date => "%b %d, %Y"    
      
      validate_configuration
    end
    
  private
    def validate_configuration
      unless configuration
        raise ConfigurationException.new("config/hush.yml doesn't define anything")
      end
      
      unless configuration['administration'] && configuration['administration']['username'] && configuration['administration']['password']
        raise ConfigurationException.new("config/hush.yml doesn't define username and password under administration")
      end
      
      configuration['post_date_format'] = configuration['post_date_format'] ? configuration['post_date_format'].to_sym : :hush_date
      
      if configuration['paginate_options']
        configuration['paginate_options'] = configuration['paginate_options'].inject({}) do |options, (key, value)|
          options[key.to_sym] = value
          options
        end
      else
        configuration['paginate_options'] = { :per_page => 10 }
      end
    end
  end
  
  class ConfigurationException < Exception
  end
end
            