# ConfigurationHelper
%w{ configuration }.each { |h| require "configuration_helper/#{h}" }

module ConfigurationHelper
  include Configuration
  
  config_path  = "#{RAILS_ROOT}/config"
  config_files = ["#{config_path}/environment.yml",
                  "#{config_path}/environments/#{RAILS_ENV}.yml"]
  
  Configuration.setup config_files
end