# frozen_string_literal: true

RSpec.configure do |config|
  config.around(mock_host_os: true) do |example|
    original_host = RbConfig::CONFIG['host_os']
    RbConfig::CONFIG['host_os'] = example.metadata[:mock_host_os]

    begin
      example.run
    ensure
      RbConfig::CONFIG['host_os'] = original_host
    end
  end

  config.around(mock_arch: true) do |example|
    original_arch = RbConfig::CONFIG['host_cpu']
    RbConfig::CONFIG['host_cpu'] = example.metadata[:mock_arch]

    begin
      example.run
    ensure
      RbConfig::CONFIG['host_cpu'] = original_arch
    end
  end
end
