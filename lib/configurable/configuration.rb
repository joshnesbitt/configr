require 'yaml'
require 'errors'
require 'configuration_block'

module Configurable
  class Configuration
    attr_accessor :base
    attr_accessor :attributes
    attr_accessor :file_or_yaml

    def initialize(file_or_yaml=nil)
      self.base = ConfigurationBlock.new
      self.file_or_yaml = file_or_yaml
    end

    def self.configure(file_or_yaml=nil)
      instance = self.new(file_or_yaml)

      yield instance.base if block_given?

      instance.attributes = instance.base.attrs

      instance.merge_configs!

      instance
    end

    def [](value)
      self.attributes[value]
    end

    def method_missing(method, *args, &block)
      # TODO: cleanup
      name = method.to_s

      case
      when name.include?("=")
        raise ConfigurationLocked, "Not allowed to configure values after configuration has been run."
      when name.include?("?")
        !self.attributes[name.gsub("?", "").to_sym].nil?
      else
        self.attributes[method.to_sym] or self.attributes[method.to_s]
      end

    end

    def merge_configs!

      self.attributes.merge!(symbolise_keys!(create_hash_from_yaml!)) if self.file_or_yaml
    end

    def symbolise_keys!(hash)
      symbolised_hash = {}
      hash.each_pair { |k,v| symbolised_hash.merge!({k.to_sym => v}) }
      symbolised_hash
    end

    private
    def create_hash_from_yaml!
      File.exists?(self.file_or_yaml) ? YAML.load_file(self.file_or_yaml) : YAML.load(self.file_or_yaml)
    end

  end


end






__END__



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
