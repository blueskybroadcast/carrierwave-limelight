require 'limelight-api/auth'
require 'limelight-api/client'

require 'carrierwave'
require 'carrierwave/limelight/version'
require 'carrierwave/storage/limelight'
require 'carrierwave/storage/limelight_file'

class CarrierWave::Uploader::Base
  add_config :limelight_credentials
  add_config :root_path
  add_config :asset_host

  configure do |config|
    config.storage_engines[:limelight] = 'CarrierWave::Storage::Limelight'
  end
end
