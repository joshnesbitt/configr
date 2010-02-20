require 'yaml'
require 'core_ext'
require 'errors'
require 'configuration_block'

module Configurable
  class Configuration
    attr_accessor :base, :attributes, :yaml
    
    def initialize(yaml=nil)
      self.base = ConfigurationBlock.new
      self.yaml = yaml
    end
    
    def self.configure(yaml=nil)
      instance = self.new(yaml)
      
      yield instance.base if block_given?
      
      instance.attributes = instance.base.attributes
      instance.merge_configs!
      
      instance
    end
    
    def [](value)
      self.attributes[value]
    end

    def method_missing(method, *args, &block)
      name = method.to_s
      
      case
      when name.include?("=")
        raise ConfigurationLocked, "Blocked from configuring values after configuration has been run."
      when name.include?("?")
        !self.attributes[name.gsub("?", "").to_sym].nil?
      else
        self.attributes[method.to_sym] or self.attributes[method.to_s]
      end
    end
    
    def merge_configs!
      return unless self.yaml
      
      other_hash = hash_from_yaml!
      
      other_hash.recursive_symbolize_keys!
      
      self.attributes.merge!(other_hash)
    end
    
    private
    def hash_from_yaml!
      File.exists?(self.yaml) ? YAML.load_file(self.yaml) : YAML.load(self.yaml)
    end
  end
end
