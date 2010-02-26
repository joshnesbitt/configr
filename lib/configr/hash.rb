module Configr
  module HashExtensions
    def symbolize_keys!
      each do |k, v|
        self.delete(k.to_s)
        self[k.to_sym] = v
      end
    end
    
    def recursive_symbolize_keys!
      symbolize_keys!
      
      values.select { |value|
        value.is_a?(::Hash) || value.is_a?(Hash)
      }.each{ |hash|
        hash.recursive_symbolize_keys!
      }
    end
  end
  
  class Hash < ::Hash
    include HashExtensions
    
    def initialize(hash)
      hash ? hash.each_pair { |key, val| self.delete(key.to_s); self[key] = val } : self
    end
    
    def normalize!
      recursive_symbolize_keys!
      
      each_pair do |key, val|
        self[key] = Hash.new(val) if val.is_a?(::Hash)
      end
    end
    
    def recursive_normalize!
      normalize!
      values.select { |val| val.is_a?(::Hash) }.each { |hash| hash.recursive_normalize! }
    end
    
    def method_missing(method, *args, &block)
      self[method]
    end
  end
end

class Hash
  include Configr::HashExtensions
  
end
