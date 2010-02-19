class ConfigurationBlock
  attr_accessor :attrs

  def initialize(attrs = {})
    @attrs = attrs
  end

  def method_missing(method, *args, &block)

    name = method.to_s.sub('=','').to_sym#Take the = off the end

    #If is's a method like foo= then assign it to the internal structure
    if(method.to_s.include?('='))
      attrs[name] = args[0]
    elsif(existing_block = @attrs[name])
      sub_block = ConfigurationBlock.new(existing_block)
    else
      #Otherwise it's a sub-block that you should store a reference to the actual created attributes
      sub_block = ConfigurationBlock.new
      @attrs[name] = sub_block.attrs
      sub_block # then return the sub_block magician so that it can continue to get at the further nested attributes
    end
  end
end
