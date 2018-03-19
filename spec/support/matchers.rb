# frozen_string_literal: true

RSpec::Matchers.define :be_an_existing_file do
  match do |actual|
    actual.is_a?(String) ? File.exist?(actual) : false
  end

  failure_message do |actual|
    "expected that file '#{actual}' exists"
  end

  failure_message_when_negated do |actual|
    "expected that file '#{actual}' does not exist"
  end
end
