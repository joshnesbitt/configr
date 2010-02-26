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

# Example of real world usage

Configuration = Configr::Configuration.configure do |config|
  config.email.from_address = "goaway@example.com"
  config.email.from_name    = "Someone"
  
  config.twitter.screen_name = "someone"
  config.twitter.password    = "somepass"
  
  config.wiki_url = "wiki.example.com"
end

puts Configuration.wiki_url
puts Configuration.twitter[:screen_name]
puts Configuration.twitter[:password]

puts Configuration.email.from_address
puts Configuration.email.from_name
