module Configurable
  describe Configuration do

    it "should have the #configure class method to instantiate the configuration" do
      Configuration.should respond_to(:configure)
    end

    it "should return nil when a value is not set" do
      config = Configuration.configure do |config|
        config.key = "value"
      end

      config.other_key.should be_nil
    end

    it "should return a value for a key when one has been set" do
      config = Configuration.configure do |config|
        config.key = "value"
      end

      config.key.should == "value"
    end

    it "should raise an error when an existing value attempts to be updated" do
      config = Configuration.configure do |config|
        config.key = "value"
      end

      lambda { config.key = "othervalue" }.should raise_error

    end

    it "should report a value being present on #attribute?" do
      config = Configuration.configure do |config|
        config.key = "value"
      end

      config.key?.should         == true
      config.other_value?.should == false
    end

    it "should load a configuration from a YAML string" do
      yaml = <<-YAML
      first_name: Josh
      location: Leeds
      YAML

      config = Configuration.configure(yaml)

      config.first_name.should == "Josh"
      config.location.should   == "Leeds"
    end

    it "should load a configuration from a YAML string and a block" do
      yaml = <<-YAML
      first_name: Josh
      location: Leeds
      YAML

      config = Configuration.configure(yaml) do |config|
        config.from_block = "value"
      end

      config.first_name.should   == "Josh"
      config.location.should     == "Leeds"
      config.from_block.should   == "value"
    end

    it "should load a configation from a YAML file" do
      file = File.expand_path(File.join('spec', 'fixtures', 'configuration.yml'))

      config = Configuration.configure(file)

      config.first_name.should == "Bob"
      config.location.should   == "Somewhere else"
    end

    it "should load a configation from a YAML file and a block" do
      file = File.expand_path(File.join('spec', 'fixtures', 'configuration.yml'))

      config = Configuration.configure(file) do |config|
        config.hello = "value"
      end

      config.first_name.should == "Bob"
      config.location.should   == "Somewhere else"
      config.hello.should      == "value"
    end

    it "should allow a value from YAML to have precedence over the block" do
      file = File.expand_path(File.join('spec', 'fixtures', 'configuration.yml'))

      config = Configuration.configure(file) do |config|
        config.first_name = "Billy"
      end

      config.first_name.should == "Bob"
    end

  end
  
end