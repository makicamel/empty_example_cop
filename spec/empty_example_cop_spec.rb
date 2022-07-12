# frozen_string_literal: true

require_relative './spec_helper'

RSpec.describe RuboCop::Cop::RSpec::EmptyExample do
  subject(:cop) { described_class.new }

  context 'without expectation' do
    it 'registers an offense' do
      expect_offense(<<-RUBY)
        it 'has offense' do
        ^^^^^^^^^^^^^^^^^^^ Empty example detected.
        end
      RUBY

      expect_correction(<<~RUBY)
      it 'has offense'
      RUBY
    end
  end

  context 'without expectation but some statement' do
    it 'registers an offense' do
      expect_offense(<<-RUBY)
        it 'has offense' do
        ^^^^^^^^^^^^^^^^^^^ Empty example detected.
          1 + 1
        end
      RUBY

      expect_correction(<<~RUBY)
      it 'has offense'
      RUBY
    end
  end

  context 'with is_expected' do
    it 'does NOT register an offense' do
      expect_no_offenses(<<-RUBY)
        it { is_expected.to eq true }
      RUBY
    end
  end

  context 'with argumented it' do
    it 'does NOT register an offense' do
      expect_no_offenses(<<-RUBY)
        it('calls') { is_expected.to eq true }
      RUBY
    end
  end

  context 'with should' do
    it 'does NOT register an offense' do
      expect_no_offenses(<<-RUBY)
        it { should validate_presence_of(:name) }
        it { should_not validate_presence_of(:name) }
      RUBY
    end
  end

  context 'with is_expected and expect' do
    it 'does NOT register an offense' do
      expect_no_offenses(<<-RUBY)
        it do
          is_expected.to eq true
          expect(subject.email).to eq 'test@example.com'
        end
      RUBY
    end
  end

  context 'with expect with block' do
    it 'does NOT register an offense' do
      expect_no_offenses(<<-RUBY)
        it do
          expect { subject }.to change { model.count }.by(1)
        end
      RUBY
    end
  end

  context 'with expect_any_instance_of' do
    it 'does NOT register an offense' do
      expect_no_offenses(<<-RUBY)
        it do
          expect_any_instance_of(Model).to receive(:save)
          subject
        end
      RUBY
    end
  end

  context 'with expect in each block' do
    it 'does NOT register an offense' do
      expect_no_offenses(<<-RUBY)
        it 'returns 10 year old users' do
          subject.users.each do |user|
            expect(user.age).to eq 10
          end
        end
      RUBY
    end
  end

  context 'with assert_response' do
    it 'does NOT register an offense' do
      expect_no_offenses(<<-RUBY)
        it do
          subject
          assert_response :unauthorized
        end
      RUBY
    end
  end
end
