# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe Envkey::Platform do
  describe '.platform_part' do
    context 'when OS is linux', mock_host_os: 'Linux' do
      it 'returns linux' do
        expect(described_class.platform_part).to eq('linux')
      end
    end

    context 'when OS is MacOS', mock_host_os: 'darwin16.7.0' do
      it 'returns darwin' do
        expect(described_class.platform_part).to eq('darwin')
      end
    end

    context 'when OS is cygwin', mock_host_os: 'Mingw' do
      it 'returns windows' do
        expect(described_class.platform_part).to eq('windows')
      end
    end

    context 'when OS is Windows', mock_host_os: 'MSWin' do
      it 'returns windows' do
        expect(described_class.platform_part).to eq('windows')
      end
    end

    context 'when OS is BSD', mock_host_os: 'BSD' do
      it 'returns freebsd' do
        expect(described_class.platform_part).to eq('freebsd')
      end
    end

    context 'when OS is not known', mock_host_os: 'fake-os' do
      it 'returns linux' do
        expect(described_class.platform_part).to eq('linux')
      end
    end
  end

  describe '.arch_part' do
    context 'when architecture is amd64', mock_arch: 'amd64' do
      it 'returns amd64' do
        expect(described_class.arch_part).to eq('amd64')
      end
    end

    context 'when architecture is x86_64', mock_arch: 'x86_64' do
      it 'returns amd64' do
        expect(described_class.arch_part).to eq('amd64')
      end
    end

    context 'when architecture is i386', mock_arch: 'i386' do
      it 'returns 386' do
        expect(described_class.arch_part).to eq('386')
      end
    end

    context 'when architecture is x86', mock_arch: 'x86' do
      it 'returns 386' do
        expect(described_class.arch_part).to eq('386')
      end
    end

    context 'when architecture is ppc', mock_arch: 'ppc' do
      it 'returns 386' do
        expect(described_class.arch_part).to eq('386')
      end
    end

    context 'when architecture is powerpc', mock_arch: 'powerpc' do
      it 'returns 386' do
        expect(described_class.arch_part).to eq('386')
      end
    end

    context 'when architecture is arm', mock_arch: 'arm' do
      it 'returns 386' do
        expect(described_class.arch_part).to eq('386')
      end
    end

    context 'when architecture is unknown', mock_arch: 'fake-arch' do
      it 'returns 386' do
        expect(described_class.arch_part).to eq('386')
      end
    end
  end

  describe '.ext' do
    context 'when OS is linux', mock_host_os: 'linux' do
      it 'returns empty string' do
        expect(described_class.ext).to eq('')
      end
    end

    context 'when OS is windows', mock_host_os: 'MSWin' do
      it 'returns .exe' do
        expect(described_class.ext).to eq('.exe')
      end
    end

    context 'when OS is unknown', mock_host_os: 'fake-os' do
      it 'returns empty string' do
        expect(described_class.ext).to eq('')
      end
    end
  end

  describe '.fetch_env_path' do
    context 'when platform is FreeBSD and arch is 386', mock_host_os: 'bsd', mock_arch: '386' do
      it 'returns a file that exists' do
        expect(described_class.fetch_env_path).to be_an_existing_file
      end
    end

    context 'when platform is FreeBSD and arch is amd64', mock_host_os: 'bsd', mock_arch: 'amd64' do
      it 'returns a file that exists' do
        expect(described_class.fetch_env_path).to be_an_existing_file
      end
    end

    context 'when platform is Linux and arch is amd64', mock_host_os: 'linux', mock_arch: '386' do
      it 'returns a file that exists' do
        expect(described_class.fetch_env_path).to be_an_existing_file
      end
    end

    context 'when platform is Linux and arch is amd64', mock_host_os: 'linux', mock_arch: 'amd64' do
      it 'returns a file that exists' do
        expect(described_class.fetch_env_path).to be_an_existing_file
      end
    end

    context 'when platform is MacOS and arch is amd64', mock_host_os: 'darwin', mock_arch: '386' do
      it 'returns a file that exists' do
        expect(described_class.fetch_env_path).to be_an_existing_file
      end
    end

    context 'when platform is MacOS and arch is amd64', mock_host_os: 'darwin', mock_arch: 'amd64' do
      it 'returns a file that exists' do
        expect(described_class.fetch_env_path).to be_an_existing_file
      end
    end

    context 'when platform is Windows and arch is amd64', mock_host_os: 'MSWin', mock_arch: '386' do
      it 'returns a file that exists' do
        expect(described_class.fetch_env_path).to be_an_existing_file
      end
    end

    context 'when platform is Windows and arch is amd64', mock_host_os: 'MSWin', mock_arch: 'amd64' do
      it 'returns a file that exists' do
        expect(described_class.fetch_env_path).to be_an_existing_file
      end
    end
  end

  describe '.lib_file_dir' do
    context 'when platform is FreeBSD and arch is 386', mock_host_os: 'bsd', mock_arch: '386' do
      it 'ends with freebsd_386' do
        expect(described_class.lib_file_dir).to start_with('envkey-fetch').and end_with('freebsd_386')
      end
    end

    context 'when platform is FreeBSD and arch is amd64', mock_host_os: 'bsd', mock_arch: 'amd64' do
      it 'ends with freebsd_amd64' do
        expect(described_class.lib_file_dir).to start_with('envkey-fetch').and end_with('freebsd_amd64')
      end
    end

    context 'when platform is Linux and arch is amd64', mock_host_os: 'linux', mock_arch: '386' do
      it 'ends with linux_386' do
        expect(described_class.lib_file_dir).to start_with('envkey-fetch').and end_with('linux_386')
      end
    end

    context 'when platform is Linux and arch is amd64', mock_host_os: 'linux', mock_arch: 'amd64' do
      it 'ends with linux_amd64' do
        expect(described_class.lib_file_dir).to start_with('envkey-fetch').and end_with('linux_amd64')
      end
    end

    context 'when platform is MacOS and arch is amd64', mock_host_os: 'darwin', mock_arch: '386' do
      it 'ends with darwin_386' do
        expect(described_class.lib_file_dir).to start_with('envkey-fetch').and end_with('darwin_386')
      end
    end

    context 'when platform is MacOS and arch is amd64', mock_host_os: 'darwin', mock_arch: 'amd64' do
      it 'ends with darwin_amd64' do
        expect(described_class.lib_file_dir).to start_with('envkey-fetch').and end_with('darwin_amd64')
      end
    end

    context 'when platform is Windows and arch is amd64', mock_host_os: 'MSWin', mock_arch: '386' do
      it 'ends with windows_386' do
        expect(described_class.lib_file_dir).to start_with('envkey-fetch').and end_with('windows_386')
      end
    end

    context 'when platform is Windows and arch is amd64', mock_host_os: 'MSWin', mock_arch: 'amd64' do
      it 'ends with windows_amd64' do
        expect(described_class.lib_file_dir).to start_with('envkey-fetch').and end_with('windows_amd64')
      end
    end
  end
end
