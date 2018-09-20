# frozen_string_literal: true

RSpec.configure do |config|
  config.around(:each, mock_env: true) do |example|
    original = ENV.to_h
    example.run
    ENV.replace(original)
  end
end
