# TODO: Move this version of hash to a namespaced Configurable::Hash.
# Don't want to conflict with other hashes elsewhere...
module Configurable
  module HashExtensions
    def symbolize_keys!
      self.each { |k, v| self[k.to_sym] = v }
    end
    
    def recursive_symbolize_keys!
      self.symbolize_keys!
      self.values.select{ |value| value.is_a?(Hash) }.each{ |hash| hash.recursive_symbolize_keys! }
    end
    
    def method_missing(method, *args, &block)
      self[method]
    end
  end
end

class Hash
  include Configurable::HashExtensions
  
end
