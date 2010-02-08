require 'yaml'

module Configurable
  class << self
    def configure(file_or_yaml=nil)
      @@configuration ||= {}
      
      if file_or_yaml
        @@configuration = File.exists?(file_or_yaml) ? YAML.load_file(file_or_yaml) : YAML.load(file_or_yaml)
      end
      
      yield(self) if block_given?
    end
    
    def method_missing(method, *args)
      method = method.to_s
      
      case
      when method.to_s.include?("=") # make this better (regex)
        @@configuration[method.to_s.gsub("=", "")] = args.first if args.first
      when (value = @@configuration[method])
        value
      else
        nil
      end
    end
  end
end
