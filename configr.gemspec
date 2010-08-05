# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{configr}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Josh Nesbitt"]
  s.date = %q{2010-08-05}
  s.description = %q{Configr aims to provide a clean interface to configuring and reading a set of configuration values. The idea evolved from using a standard hash as a configuration store into a more elegant way to declare and read values from within a hash. }
  s.email = %q{josh@josh-nesbitt.net}
  s.extra_rdoc_files = [
    "LICENSE"
  ]
  s.files = [
    ".gitignore",
     "LICENSE",
     "Rakefile",
     "VERSION",
     "configr.gemspec",
     "examples/all.rb",
     "lib/configr.rb",
     "lib/configr/configuration.rb",
     "lib/configr/configuration_block.rb",
     "lib/configr/errors.rb",
     "lib/configr/hash.rb",
     "readme.rdoc",
     "spec/fixtures/configuration.yml",
     "spec/lib/configuration_block_spec.rb",
     "spec/lib/configuration_spec.rb",
     "spec/lib/errors_spec.rb",
     "spec/lib/hash_spec.rb",
     "spec/spec_helper.rb",
     "spec/watch.rb"
  ]
  s.homepage = %q{http://github.com/joshnesbitt/configr}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{An elegant approach to creating and accessing configuration values.}
  s.test_files = [
    "spec/lib/configuration_block_spec.rb",
     "spec/lib/configuration_spec.rb",
     "spec/lib/errors_spec.rb",
     "spec/lib/hash_spec.rb",
     "spec/spec_helper.rb",
     "spec/watch.rb",
     "examples/all.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
  end
end

