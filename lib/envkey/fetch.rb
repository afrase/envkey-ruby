require 'envkey/platform'

module Envkey::Fetch

  def self.fetch_env key
    fetch_env_path = Envkey::Platform.fetch_env_path
    `#{fetch_env_path} #{key}#{is_dev ? ' --cache' : ''}`
  end

  def self.is_dev
    dev_vals = %w(development test)
    dev_vals.include?(ENV["RAILS_ENV"]) ||
    dev_vals.include?(ENV["RACK_ENV"])
  end

end