# EmptyExampleCop

EmptyExampleCop is a tiny custom cop to detect empty examples which don't include any expectations.  

```ruby
  # bad
  describe Bacon do
    let(:bacon)      { Bacon.new(chunkiness) }
    let(:chunkiness) { true }

    it 'is chunky' do
      bacon.chunky?
    end
  end

  # good
  describe Bacon do
    let(:bacon)      { Bacon.new(chunkiness) }
    let(:chunkiness) { true }

    it 'is chunky' do
      expect(bacon.chunky?).to be_truthy
    end
  end
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'empty_example_cop', require: false
```

## Usage

Add `empty_example_cop` to your `.rubocop.yml`:

```yml
require:
  - rubocop-rspec
  - empty_example_cop
```

```console
bundle exec rubocop <options>
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/makicamel/empty_example_cop. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/makicamel/empty_example_cop/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the EmptyExampleCop project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/makicamel/empty_example_cop/blob/master/CODE_OF_CONDUCT.md).
