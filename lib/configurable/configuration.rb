module Configuration
  mattr_accessor :config
  
  def self.setup(files)
    files.each { |f| load f }
    # Include for models, mailers and controllers
    ActionController::Base.send :include, Helpers
    ActiveRecord::Base.send :include, Helpers
    ActionMailer::Base.send :include, Helpers
  end
  
  def self.load(filename)
    if File.exists?(filename) && (env_config = YAML.load_file(filename))
      if @@config.nil?
        @@config = env_config
      else
        @@config.merge! env_config
      end
    end
  end
  
  module Helpers
    
    def self.included(base)
      if base.respond_to? :helper_method
        base.send :helper_method, :get_config
        base.send :helper_method, :c
      end
    end
    
    def get_config(*args)
      value = Configuration.config
      arg_count = args.length
      i = 0
      while(value and i < arg_count)
        key = args[i]
        key = key.to_s if key.is_a? Symbol
        value = value[key]
        i = i + 1
      end
      value
    end
    alias_method :c, :get_config
    
  end

end