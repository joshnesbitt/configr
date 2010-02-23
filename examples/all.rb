require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'configurable'))


# Standalone (without YAML)

config = Configurable::Configuration.configure do |config|
  config.example_one = "One"
  config.example_two = "Two"
end

puts config.example_one
puts config.example_two
puts config.doesnt_exist


# With YAML (inline)

yaml = <<CONTENT

example_one: "Oooooo"
example_two: "It loads from YAML too!"

CONTENT

config = Configurable::Configuration.configure(yaml)

puts config.example_one
puts config.example_two


# With YAML (file)

config = Configurable::Configuration.configure(File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec', 'fixtures', 'configuration.yml')))

puts config.first_name
puts config.location


# Or go nuts (inline yaml and block)

yaml = <<CONTENT

example_three: "Oooooo"
example_four: "It loads from YAML too!"

CONTENT

config = Configurable::Configuration.configure(yaml) do |config|
  config.example_one = "One"
  config.example_two = "Two"
end

puts config.example_one
puts config.example_two
puts config.example_three
puts config.example_four

# Good for things like this

c = Configurable::Configuration.configure do |config|
  config.support_email    = "josh@josh-nesbitt.net"
  config.google_analytics = "UA-x343x-SDS"
  
  config.twitter.screen_name = "joshnesbitt"
  config.twitter.password    = "mypassword"
  
  config.one.long.value.chain = "value"
end

puts c.support_email
puts c.google_analytics
puts c.twitter[:screen_name]
puts c.twitter[:password]

puts c.twitter.screen_name
puts c.twitter.password
puts c.one.long.value.chain
