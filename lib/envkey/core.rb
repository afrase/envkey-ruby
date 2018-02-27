# frozen_string_literal: true

require 'set'
require 'json'
require 'dotenv'

require_relative 'fetch'

module Envkey
  class Core
    def self.load_env(overload_dotenv_vars=[], overload_envkey_vars=[]) # rubocop:disable all
      original_env = ENV.to_h
      dotenv_vars = Dotenv.load
      updated_dotenv_vars = dotenv_vars.keys.select do |k|
        overload_dotenv_vars.include?(k) || original_env[k].nil?
      end
      overload_dotenv_vars.each do |k|
        ENV[k] = dotenv_vars[k]
      end

      if (key = ENV['ENVKEY'])
        res = Envkey::Fetch.fetch_env(key)
        if res&.gsub("\n", '')&.delete("\r") != '' && !res.start_with?('error:') # rubocop:disable GuardClause
          envs = JSON.parse(res)
          updated_envkey_vars = []
          envs.each do |k, v|
            var = k.upcase
            if !ENV[var] || overload_envkey_vars.include?(var)
              updated_envkey_vars << var
              ENV[var] = v
            end
          end

          return [Set.new(updated_dotenv_vars), Set.new(updated_envkey_vars)]
        else
          raise "ENVKEY invalid. Couldn't load vars."
        end
      else
        raise 'ENVKEY missing - must be set as an environment variable or in a gitignored .env file in the root of '\
              "your project. Go to https://www.envkey.com if you don't know what an ENVKEY is."
      end
    end
  end
end
