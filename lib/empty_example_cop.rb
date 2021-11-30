# frozen_string_literal: true

require 'rubocop'
require_relative './empty_example_cop/version'

module EmptyExampleCop
  class Error < StandardError; end

  module RSpec
    # Checks if an example does not include any expectations.
    #
    # @example usage
    #
    #   # bad
    #   describe Bacon do
    #     let(:bacon)      { Bacon.new(chunkiness) }
    #     let(:chunkiness) { true }
    #
    #     it 'is chunky' do
    #       bacon.chunky?
    #     end
    #   end
    #
    #   # good
    #   describe Bacon do
    #     let(:bacon)      { Bacon.new(chunkiness) }
    #     let(:chunkiness) { true }
    #
    #     it 'is chunky' do
    #       expect(bacon.chunky?).to be_truthy
    #     end
    #   end
    class EmptyExample < RuboCop::Cop::Cop
      MSG = 'Empty example detected.'

      def_node_matcher :it_description?, <<-PATTERN
        (block
          (send nil? :it ...) ...)
      PATTERN

      def_node_matcher :expect?, <<-PATTERN
        (send nil? {:expect :is_expected :expect_any_instance_of} ...)
      PATTERN

      def_node_matcher :should?, <<-PATTERN
        (send nil? {:should :should_not} ...)
      PATTERN

      def_node_matcher :assert?, <<-PATTERN
        (send nil? {:assert_response} ...)
      PATTERN

      def on_block(node)
        return unless it_description?(node)

        unless example_present?(node)
          add_offense(node, message: MSG)
        end
      end

      private

      def example_present?(node)
        if expect?(node) || should?(node) || assert?(node)
          true
        elsif node.nil?
          false
        elsif RuboCop::AST::Node === node && node.children.size > 0
          node.children.any? { |child| example_present?(child) }
        else # something not expectation
          false
        end
      end
    end
  end
end
