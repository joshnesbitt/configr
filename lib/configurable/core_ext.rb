class Hash
  def symbolize_keys!
    self.each { |k, v| self[k.to_sym] = v }
  end
  
  def recursive_symbolize_keys!
    self.symbolize_keys!
    self.values.select{ |value| value.is_a?(Hash) }.each{ |hash| hash.recursive_symbolize_keys! }
  end
end
