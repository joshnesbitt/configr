module Configr
  class ConfigurationBlock
    attr_accessor :attributes

    def initialize(attributes={})
      self.attributes = Hash.new(attributes)
    end
    
    def method_missing(method, *args, &block)
      name = method.to_s
      
      case
      when name.include?('=')
        key = name.gsub('=','').to_sym
        self.attributes[key] = args.first
      when existing_block_attributes = self.attributes[method]
        existing_block = ConfigurationBlock.new(existing_block_attributes)
        self.attributes[method] = existing_block.attributes
        existing_block
      else
        nested_block = ConfigurationBlock.new
        self.attributes[method] = nested_block.attributes
        nested_block
      end
    end
  end
end
