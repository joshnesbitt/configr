# TODO: Move this version of hash to a namespaced Configurable::Hash.
# Don't want to conflict with other hashes elsewhere...
module Configurable
  class Hash < ::Hash
    
    def initialize(hash)
      hash.each_pair { |key, val| self[key] = val }
    end
    
    def symbolize_keys!
      self.each { |k, v| self[k.to_sym] = v }
    end
    
    def recursive_symbolize_keys!
      self.symbolize_keys!
      self.values.select{ |value| value.is_a?(Hash) }.each{ |hash| hash.recursive_symbolize_keys! }
    end
    
    def normalize!
      recursive_symbolize_keys!
      
      each_pair do |key, val|
        self[key] = Hash.new(val) if val.is_a?(Hash)
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
