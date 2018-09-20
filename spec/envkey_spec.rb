# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Envkey, mock_env: true do
  it 'has a version number' do
    expect(Envkey::VERSION).not_to be nil
  end

  it 'has an envkey-fetch version number' do
    expect(Envkey::ENVKEY_FETCH_VERSION).not_to be_nil
  end

  context 'when ENVKEY is valid' do
    before do
      ENV['ENVKEY'] = 'foo'
      allow(Envkey::Fetch).to receive(:fetch_env).and_return('{"KEY1":"key1","KEY2":"key2"}')
    end

    it 'sets the environment variables' do
      Envkey::Core.load_env
      aggregate_failures do
        expect(ENV['KEY1']).to eq('key1')
        expect(ENV['KEY2']).to eq('key2')
      end
    end

    it 'does not overwrite existing environment variables' do
      ENV['KEY1'] = 'foo'
      Envkey::Core.load_env
      expect(ENV['KEY1']).to eq('foo')
    end

    context 'when fetch results are empty' do
      before do
        allow(Envkey::Fetch).to receive(:fetch_env).and_return("\r\n")
      end

      it 'raises an error' do
        expect { Envkey::Core.load_env }.to raise_error(/ENVKEY invalid/)
      end
    end
  end

  context 'when ENVKEY is invalid' do
    before do
      ENV['ENVKEY'] = 'foo'
      allow(Envkey::Fetch).to receive(:fetch_env).and_return('error: ENVKEY invalid')
    end

    it 'raises an error' do
      expect { Envkey::Core.load_env }.to raise_error(/ENVKEY invalid/)
    end
  end

  context 'when ENVKEY is not set' do
    it 'raises an error' do
      expect { Envkey::Core.load_env }.to raise_error(/ENVKEY missing/)
    end
  end
end
