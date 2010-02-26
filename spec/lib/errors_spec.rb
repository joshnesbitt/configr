module Configr
  describe Hash do
    
    it "should have a base error class" do
      error = Configr::ConfigrError.new("Error data")
      
      error.data.should == "Error data"
      Configr::ConfigrError.ancestors.should include(StandardError)
    end
    
  end
end
