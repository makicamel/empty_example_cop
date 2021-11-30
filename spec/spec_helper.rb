# frozen_string_literal: true

require 'empty_example_cop'
require 'rubocop/rspec/support'

RSpec.configure do |config|
  config.example_status_persistence_file_path = 'spec/examples.txt'
  config.disable_monkey_patching!
  config.include(RuboCop::RSpec::ExpectOffense)

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
