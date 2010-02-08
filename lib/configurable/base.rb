require 'yaml'
require 'hashie'
require 'errors'

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
      raise NotConfigured, "No configuration has been loaded yet" unless defined?(@@configuration)
      
      method = method.to_s
      last   = method[method.size - 1].chr
      
      case
      when last == "="
        @@configuration[method.gsub("=", "")] = args.first if args.first
      when last == "?"
        !@@configuration[method.gsub("?", "")].nil?
      when (value = @@configuration[method])
        value
      else
        nil
      end
    end
  end
end
