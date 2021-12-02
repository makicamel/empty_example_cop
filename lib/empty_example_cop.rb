# frozen_string_literal: true

require 'rubocop'
require_relative './empty_example_cop/version'
require_relative './empty_example_cop/inject'

RuboCop::EmptyExampleCop::Inject.defaults!

require_relative './rubocop/cop/rspec/empty_example_cops'
