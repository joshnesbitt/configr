module Configr
  describe Hash do
    
    it "should create a Configr Hash from an existing hash" do
      hash = Hash.new({ :one => "one", :two => "two" })
      
      hash[:one].should == "one"
      hash[:two].should == "two"
    end
    
    it "should symbolize a set of string keys" do
      hash = Hash.new({ "one" => "one", "two" => "two" })
      
      hash["one"].should == "one"
      hash["two"].should == "two"
      
      hash[:one].should be_nil
      hash[:two].should be_nil
      
      hash.symbolize_keys!
      
      hash["one"].should be_nil
      hash["two"].should be_nil
      
      hash[:one].should == "one"
      hash[:two].should == "two"
    end
    
    it "should recursively symbolize a set of string keys" do
      hash = Hash.new({ "one" => "one", "two" => "two", "three" => { "four" => "four" } })
      
      hash["one"].should   == "one"
      hash["two"].should   == "two"
      hash["three"]["four"].should == "four"
      
      hash[:one].should be_nil
      hash[:two].should be_nil
      hash[:three].should be_nil
      
      hash.recursive_symbolize_keys!
      
      hash["one"].should be_nil
      hash["two"].should be_nil
      hash["three"].should be_nil
      
      hash[:one].should == "one"
      hash[:two].should == "two"
      hash[:three][:four].should == "four"
    end
    
    it "should normalize a set of Hash values to a Configr Hash if they are themselves Hashes" do
      hash = Hash.new({ "one" => "one", "two" => "two", "three" => { "four" => "four" } })
      
      hash["three"].class.should == ::Hash
      
      hash.normalize!
      
      hash[:three].class.should == Configr::Hash
    end
    
    it "should recursively normalize a set of Hash values to a Configr Hash if they are themselves Hashes" do
      hash = Hash.new({ "one" => "one", "two" => "two", "three" => { "four" => "four", "five" => { "six" => "six" } } })
      
      hash["three"].class.should         == ::Hash
      hash["three"]["five"].class.should == ::Hash
      
      hash.recursive_normalize!
      
      hash[:three].class.should        == Configr::Hash
      hash[:three][:five].class.should == Configr::Hash
    end
    
    it "should allow method based access to hash keys" do
      hash = Hash.new({ :one => "one", :two => "two" })
      
      hash.one.should == "one"
      hash.two.should == "two"
    end
    
    it "should return true when using the #method? for asserting a values presence" do
      hash = Hash.new({ :one => "one", :two => "two" })
      
      hash.one?.should   == true
      hash.two?.should   == true
      hash.three?.should == false
    end
    
    it "should raise an error when a value is assigned" do
      hash = Hash.new({ :one => "one", :two => "two" })
      
      lambda { hash.some_value = "this" }.should raise_error(Configr::ConfigurationLocked)
    end
    
  end
end
