describe Configurable do
  
  it "should present the #configure class method to instantiate the configuration" do
    Configurable.should respond_to(:configure)
  end
  
end
