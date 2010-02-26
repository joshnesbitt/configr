module Configr
  class ConfigrError < StandardError
    attr_accessor :data
    
    def initialize(data)
      self.data = data
      super
    end
  end
  
  class ConfigurationLocked < ConfigrError; end
  
end
