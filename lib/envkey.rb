# frozen_string_literal: true

if defined?(::Rails)
  require 'envkey/rails'
else
  require 'envkey/core'
  Envkey::Core.load_env
end
