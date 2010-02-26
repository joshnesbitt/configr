module Configr
  describe ConfigurationBlock do
    before do
      @hash  = { :one => "one", :two => "two" }
      @block = ConfigurationBlock.new(@hash)
    end
    
    it "should convert a standard Hash to a Configr Hash on creation" do
      @block.attributes.class.should == Configr::Hash
    end
    
    it "should assign a value when the missing method looks likes a setter" do
      @block.something      = "value"
      @block.something_else = "value"
      
      @block.attributes[:something].should      == "value"
      @block.attributes[:something_else].should == "value"
    end
    
    it "should allow you to continue to create nested ConfigurationBlocks within each other" do
      @block.something.else          = "else"
      @block.something.again         = "again"
      @block.something.nested.within = "within"
      
      @block.attributes[:something][:else].should            == "else"
      @block.attributes[:something][:again].should           == "again"
      @block.attributes[:something][:nested][:within].should == "within"
    end
    
    it "should return an existing block if an assignment is made within the same nested level" do
      @block.first.second.var1 = "var1"
      @block.first.second.var2 = "var2"
      @block.first.second.var3 = "var3"
      @block.first.second.var4 = "var4"
      @block.first.second.var5 = "var5"
      @block.first.second.var6 = "var6"
      
      @block.attributes[:first][:second][:var1].should == "var1"
      @block.attributes[:first][:second][:var2].should == "var2"
      @block.attributes[:first][:second][:var3].should == "var3"
      @block.attributes[:first][:second][:var4].should == "var4"
      @block.attributes[:first][:second][:var5].should == "var5"
      @block.attributes[:first][:second][:var6].should == "var6"
    end
    
    it "should return a new ConfigurationBlock if that nested level has not been created yet" do
      @block.five.class.should           == ConfigurationBlock
      @block.five.six.class.should       == ConfigurationBlock
      @block.five.six.seven.class.should == ConfigurationBlock
    end
  end
end
