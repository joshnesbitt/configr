describe Configurable do
  
  it "should have the #configure class method to instantiate the configuration" do
    Configurable.should respond_to(:configure)
  end
  
  it "should error if the configuration has not been loaded" do
    lambda { Configurable.some_key }.should raise_error(Configurable::NotConfigured)
  end
  
  it "should return nil when a value is not set" do
    Configurable.configure do |config|
      config.key = "value"
    end
    
    Configurable.other_key.should be_nil
  end
  
  it "should return a value for a key when one has been set" do
    Configurable.configure do |config|
      config.key = "value"
    end
    
    Configurable.key.should == "value"
  end
  
  it "should allow an existing value to be updated" do
    Configurable.configure do |config|
      config.key = "value"
    end
    
    Configurable.key.should == "value"
    Configurable.key         = "other_value"
    Configurable.key.should == "other_value"
  end
  
  it "should report a value being present on #attribute?" do
    Configurable.configure do |config|
      config.key = "value"
    end
    
    Configurable.key?.should         == true
    Configurable.other_value?.should == false
  end
  
  it "should load a configuration from a YAML string" do
    yaml = <<-YAML
    first_name: Josh
    location: Leeds
    YAML
    
    Configurable.configure(yaml)
    
    Configurable.first_name.should == "Josh"
    Configurable.location.should   == "Leeds"
  end
  
  it "should load a configuration from a YAML string and a block" do
    yaml = <<-YAML
    first_name: Josh
    location: Leeds
    YAML
    
    Configurable.configure(yaml) do |config|
      config.from_block = "value"
    end
    
    Configurable.first_name.should   == "Josh"
    Configurable.location.should     == "Leeds"
    Configurable.from_block.should   == "value"
  end
  
  it "should load a configation from a YAML file" do
    file = File.expand_path(File.join('spec', 'fixtures', 'configuration.yml'))
    
    Configurable.configure(file)
    
    Configurable.first_name.should == "Bob"
    Configurable.location.should   == "Somewhere else"
  end
  
  it "should load a configation from a YAML file and a block" do
    file = File.expand_path(File.join('spec', 'fixtures', 'configuration.yml'))
    
    Configurable.configure(file) do |config|
      config.hello = "value"
    end
    
    Configurable.first_name.should == "Bob"
    Configurable.location.should   == "Somewhere else"
    Configurable.hello.should      == "value"
  end
  
  it "should allow a value from YAML to be overriden through the block" do
    file = File.expand_path(File.join('spec', 'fixtures', 'configuration.yml'))
    
    Configurable.configure(file) do |config|
      config.hello = "value"
    end
    
    Configurable.first_name.should == "Bob"
    
    Configurable.configure(file) do |config|
      config.first_name = "Billy"
    end
    
    Configurable.first_name.should == "Billy"
  end
  
end
