# frozen_string_literal: true

# The original code is from https://github.com/rubocop-hq/rubocop-rspec/blob/master/lib/rubocop/rspec/inject.rb and
# https://github.com/rubocop/rubocop-extension-generator/blob/master/lib/rubocop/extension/generator/generator.rb
# See https://github.com/rubocop-hq/rubocop-rspec/blob/master/MIT-LICENSE.md
module RuboCop
  module EmptyExampleCop
    # Because RuboCop doesn't yet support plugins, we have to monkey patch in a
    # bit of our configuration.
    module Inject
      def self.defaults!
        project_root = Pathname.new(__dir__).parent.parent.expand_path.freeze
        config_default = project_root.join('config', 'default.yml').freeze
        path = config_default.to_s
        hash = ConfigLoader.send(:load_yaml_configuration, path)
        config = Config.new(hash, path).tap(&:make_excludes_absolute)
        puts "configuration from #{path}" if ConfigLoader.debug?
        config = ConfigLoader.merge_with_default(config, path)
        ConfigLoader.instance_variable_set(:@default_configuration, config)
      end
    end
  end
end
