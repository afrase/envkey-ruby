# frozen_string_literal: true

module Envkey
  require_relative 'platform'

  class Fetch
    # @param [String] key
    # @return [String]
    def self.fetch_env(key)
      fetch_env_path = Envkey::Platform.fetch_env_path
      `#{fetch_env_path} #{key}#{dev? ? ' --cache' : ''} --client-name envkey-ruby --client-version #{Envkey::VERSION}`
    end

    class << self
      private

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
