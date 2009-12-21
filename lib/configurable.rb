# Configurable
require File.join(File.dirname(__FILE__), "configurable", "configuration")

module Configurable
  include Configuration
  
  config_path  = File.join(RAILS_ROOT, "config")
  config_files = [File.join(config_path, "environment.yml"),
                  File.join(config_path, "environments", "#{RAILS_ENV}.yml")]
  
  Configuration.setup config_files
  
end