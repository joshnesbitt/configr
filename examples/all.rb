require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'configr'))

# Standalone (without YAML)

configuration = Configr::Configuration.configure do |config|
  config.example_one = "One"
  config.example_two = "Two"
end

puts configuration.example_one
puts configuration.example_two
puts configuration.doesnt_exist


# With YAML (inline)

yaml = <<YAML

example_one: "Oooooo"
example_two: "It loads from YAML too!"

YAML

configuration = Configr::Configuration.configure(yaml)

puts configuration.example_one
puts configuration.example_two


# With YAML (file)

configuration = Configr::Configuration.configure(File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec', 'fixtures', 'configuration.yml')))

puts configuration.first_name
puts configuration.location


# Or go nuts (inline yaml and block)

yaml = <<YAML

example_three: "Oooooo"
example_four: "It loads from YAML too!"

YAML

configuration = Configr::Configuration.configure(yaml) do |config|
  config.example_one = "One"
  config.example_two = "Two"
end

puts configuration.example_one
puts configuration.example_two
puts configuration.example_three
puts configuration.example_four

# Good for things like this

Config = Configr::Configuration.configure do |config|
  config.support_email    = "goaway@example.com"
  config.google_analytics = "UA-x343x-SDS"
  
  config.twitter.screen_name = "someone"
  config.twitter.password    = "somepass"
end

puts Config.support_email
puts Config.google_analytics
puts Config.twitter[:screen_name]
puts Config.twitter[:password]

puts Config.twitter.screen_name
puts Config.twitter.password
