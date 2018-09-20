# frozen_string_literal: true

require 'envkey/platform'
require 'envkey/version'

module Envkey
  class Fetch
    class << self
      # @param [String] key
      # @return [String]
      def fetch_env(key)
        call_fetch(key, dev? ? ' --cache' : '', '--client-name', 'envkey-ruby', '--client-version', Envkey::VERSION)
      end

      private

      def call_fetch(*args)
        `#{Envkey::Platform.fetch_env_path} #{args.join(' ')}`
      end

      # @return [Boolean]
      def dev?
        dev_vals = %w[development test]
        dev_vals.include?(ENV['RAILS_ENV']) ||
          dev_vals.include?(ENV['RACK_ENV']) ||
          (ENV['RAILS_ENV'].nil? && ENV['RACK_ENV'].nil? && File.exist?('.env'))
      end
    end
  end
end
