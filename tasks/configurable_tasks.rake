namespace :configurable do
  
  PLUGIN_ROOT  = File.join(File.dirname(__FILE__), "..")
  ENVIRONMENTS = %w{ "development staging production }
  
  desc 'Copies the configuration files for configurable into RAILS_ROOT/config'
  task :install do
    FileUtils.cp Dir[PLUGIN_ROOT + "/templates/configuration/environment.yml"], RAILS_ROOT + '/config'
    ENVIRONMENTS.each { |f| FileUtils.cp(Dir[PLUGIN_ROOT + "/templates/configuration/#{f}.yml"], RAILS_ROOT + '/config/environments') }
    puts "+ configuration files successfully copied to config/"
  end

end