require 'yaml'
require 'hash'
require 'errors'
require 'configuration_block'

module Configr
  class Configuration
    
    def self.configure(yaml=nil)
      instance = self.new(yaml)
      
      yield instance.base if block_given?
      
      instance.attributes = instance.base.attributes
      
      instance.merge_configurations!
      
      instance.attributes.recursive_normalize!
      
      instance
    end
    
    attr_accessor :base, :attributes, :yaml
    
    def initialize(yaml=nil)
      self.base = ConfigurationBlock.new
      self.yaml = yaml
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
    
    def merge_configurations!
      return unless self.yaml
      
      self.yaml = self.yaml.to_s
      
      hash = if File.exists?(self.yaml)
        YAML.load_file(self.yaml)
      else
        YAML.load(self.yaml)
      end
      
      hash = Hash.new(hash)
      hash.recursive_symbolize_keys!
      
      self.attributes.merge!(hash)
    end
  end
end
