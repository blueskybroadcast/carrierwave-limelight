require 'pry-byebug'
require 'carrierwave'
require 'carrierwave/limelight'
require 'webmock/rspec'
require 'support/helpers/limelight_api_helper'

def source_environment_file!
  return unless File.exists?('.env')

  File.readlines('.env').each do |line|
    values = line.split('=')
    ENV[values.first] = values.last.chomp
  end
end

RSpec.configure do |config|
  source_environment_file!
end
