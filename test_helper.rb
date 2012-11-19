require 'simplecov'

SimpleCov.start
SimpleCov.command_name "Test::Unit"
SimpleCov.start do
  add_filter 'tests.rb'
end