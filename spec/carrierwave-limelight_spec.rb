require 'spec_helper'

describe CarrierWave::Uploader::Base do
  it 'defines limelight specific storage options' do
    expect(described_class).to respond_to(:limelight_credentials)
    expect(described_class).to respond_to(:root_path)
    expect(described_class).to respond_to(:asset_host)
  end

  it 'inserts limelight as a known storage engine' do
    described_class.configure do |config|
      expect(config.storage_engines).to have_key(:limelight)
    end
  end
end
