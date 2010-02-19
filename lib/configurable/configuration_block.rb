class ConfigurationBlock
  attr_accessor :attributes
  
  def initialize(attributes = {})
    @attributes = attributes
  end
  
  def method_missing(method, *args, &block)
    name = method.to_s
    
    if(name.include?('='))
      attributes[name.gsub('=','').to_sym] = args.first
    elsif(existing_block = @attributes[method])
      ConfigurationBlock.new(existing_block)
    else
      nested_block = ConfigurationBlock.new
      @attributes[method] = nested_block.attributes
      nested_block
    end
  end
end
