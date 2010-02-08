$:.unshift File.dirname(__FILE__)
$:.unshift File.join(File.dirname(__FILE__), "configurable")

path     = File.dirname(__FILE__)
vendored = File.expand_path(File.join(path, '..', 'vendor', '*', 'lib'))

Dir.glob(vendored).each { |path| $:.unshift(path) }

require 'configurable/base'
