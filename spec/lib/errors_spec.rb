module Configr
  describe Hash do
    
    it "should have a base error class defined for Configr" do
      Configr::ConfigrError.ancestors.should include(StandardError)
      
      error = Configr::ConfigrError.new("Error data")
      
      error.data.should == "Error data"
    end
    
  end
end
