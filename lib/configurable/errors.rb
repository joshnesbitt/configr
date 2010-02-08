module Configurable
  class ConfigurableError < StandardError
    attr_accessor :data
    
    def initialize(data)
      self.data = data
      super
    end
  end
  
  class NotConfigured < ConfigurableError; end
  
end
