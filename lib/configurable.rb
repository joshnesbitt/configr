# Configurable
%w{ configuration }.each { |h| require "configurable/#{h}" }

module Configurable
  include Configuration
  
  config_path  = "#{RAILS_ROOT}/config"
  config_files = ["#{config_path}/environment.yml",
                  "#{config_path}/environments/#{RAILS_ENV}.yml"]
  
  Configuration.setup config_files
end