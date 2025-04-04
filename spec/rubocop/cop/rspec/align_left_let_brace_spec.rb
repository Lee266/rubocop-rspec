# frozen_string_literal: true

RSpec.describe RuboCop::Cop::RSpec::AlignLeftLetBrace do
  it 'registers offense for unaligned braces' do
    expect_offense(<<~RUBY)
      let(:foo) { bar }
                ^ Align left let brace
      let(:hi) { baz }
               ^ Align left let brace
      let(:blahblah) { baz }

      let(:thing) { ignore_this }
      let(:other) {
        ignore_this_too
      }

      describe 'blah' do
        let(:long_name) { thing }
        let(:blah) { thing }
                   ^ Align left let brace
        let(:a) { thing }
                ^ Align left let brace
      end
    RUBY

    expect_correction(<<~RUBY)
      let(:foo)      { bar }
      let(:hi)       { baz }
      let(:blahblah) { baz }

      let(:thing) { ignore_this }
      let(:other) {
        ignore_this_too
      }

      describe 'blah' do
        let(:long_name) { thing }
        let(:blah)      { thing }
        let(:a)         { thing }
      end
    RUBY
  end

  it 'does not register an offense for let with proc argument' do
    expect_no_offenses(<<~RUBY)
      let(:user, &args[:build_user])
    RUBY
  end

  it 'does not register an offense with empty file' do
    expect_no_offenses('')
  end
end
