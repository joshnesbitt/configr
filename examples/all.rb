require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'configurable'))


# Standalone (without YAML)

Configurable.configure do |config|
  config.example_one = "One"
  config.example_two = "Two"
end

puts Configurable.example_one
puts Configurable.example_two
puts Configurable.doesnt_exist


# With YAML (inline)

yaml = <<CONTENT

example_one: "Oooooo"
example_two: "It loads from YAML too!"

CONTENT

Configurable.configure(yaml)

puts Configurable.example_one
puts Configurable.example_two


# With YAML (file)

Configurable.configure("config.yml")

puts Configurable.example_one
puts Configurable.example_two


# Or go nuts (inline yaml and block)

yaml = <<CONTENT

example_three: "Oooooo"
example_four: "It loads from YAML too!"

CONTENT

Configurable.configure(yaml) do |config|
  config.example_one = "One"
  config.example_two = "Two"
end

puts Configurable.example_one
puts Configurable.example_two
puts Configurable.example_three
puts Configurable.example_four
