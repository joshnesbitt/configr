module Configr
  describe Configuration do

    it "should have the #configure class method to instantiate the configuration" do
      Configuration.should respond_to(:configure)
    end

    it "should return nil when a value is not set" do
      configuration = Configuration.configure do |config|
        config.key = "value"
      end

      configuration.other_key.should be_nil
    end

    it "should return a value for a key when one has been set" do
      configuration = Configuration.configure do |config|
        config.key = "value"
      end

      configuration.key.should == "value"
    end

    it "should raise an error when an existing value attempts to be updated" do
      configuration = Configuration.configure do |config|
        config.key = "value"
      end

      lambda { configuration.key = "othervalue" }.should raise_error(Configr::ConfigurationLocked)
    end

    it "should report a value being present on #attribute?" do
      configuration = Configuration.configure do |config|
        config.key = "value"
      end

      configuration.key?.should         == true
      configuration.other_value?.should == false
    end

    it "should load a configuration from a YAML string" do
      yaml = <<-YAML
      first_name: Josh
      location: Leeds
      YAML

      configuration = Configuration.configure(yaml)

      configuration.first_name.should == "Josh"
      configuration.location.should   == "Leeds"
    end

    it "should load a configuration from a YAML string and a block" do
      yaml = <<-YAML
      first_name: Josh
      location: Leeds
      YAML

      configuration = Configuration.configure(yaml) do |config|
        config.from_block = "value"
      end

      configuration.first_name.should   == "Josh"
      configuration.location.should     == "Leeds"
      configuration.from_block.should   == "value"
    end

    it "should load a configation from a YAML file" do
      file = File.expand_path(File.join('spec', 'fixtures', 'configuration.yml'))

      configuration = Configuration.configure(file)

      configuration.first_name.should == "Bob"
      configuration.location.should   == "Somewhere else"
    end

    it "should load a configation from a YAML file and a block" do
      file = File.expand_path(File.join('spec', 'fixtures', 'configuration.yml'))

      configuration = Configuration.configure(file) do |config|
        config.hello = "value"
      end

      configuration.first_name.should == "Bob"
      configuration.location.should   == "Somewhere else"
      configuration.hello.should      == "value"
    end

    it "should allow a value from YAML to have precedence over the block" do
      file = File.expand_path(File.join('spec', 'fixtures', 'configuration.yml'))

      configuration = Configuration.configure(file) do |config|
        config.first_name = "Billy"
      end

      configuration.first_name.should == "Bob"
    end
    
    it "should allow a deeply nested hash to be accessed with hash notation" do
      configuration = Configuration.configure do |config|
        config.one.two.three.four = "value"
      end
      
      configuration.one[:two][:three][:four].should == "value"
    end
    
    it "should allow more than one value to be assigned within the same namespace" do
      configuration = Configuration.configure do |config|
        config.one.two.three.var1 = "value one"
        config.one.two.three.var2 = "value two"
        config.one.two.three.var3 = "value three"
      end
      
      configuration.one[:two][:three][:var1].should == "value one"
      configuration.one[:two][:three][:var2].should == "value two"
      configuration.one[:two][:three][:var3].should == "value three"
    end
    
    it "should allow method like lookup of attributes" do
      configuration = Configuration.configure do |config|
        config.one.two.three.var1 = "value"
      end
      
      configuration.one.two.three.var1.should == "value"
    end
  end
end
