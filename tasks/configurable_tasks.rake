namespace :configurable do
  
  desc 'Copies the configuration files for configurable into RAILS_ROOT/config'
  task :install do
    plugin_root  = File.join(File.dirname(__FILE__), "..")
    environments = %w{ development staging production }
    
    template   = File.join(plugin_root, "templates", "settings.yml")
    destination = File.join(RAILS_ROOT, "config")
    
    FileUtils.cp template, File.join(destination, "environment.yml")
    
    environments.each { |f| FileUtils.cp(template, File.join(destination, "environments", "#{f}.yml")) }
    puts ">> Added configuration files:"
    puts "+ config/environment.yml"
    environments.each { |e| puts "+ config/environments/#{e}.yml" }
  end
  
end