require 'spec_helper'

describe LimelightApi::Auth do
  include LimelightApiHelper

  before do
    limelight_api_auth
  end

  it 'token must be present' do
    limelight_api = LimelightApi::Auth.new
    expect(limelight_api.token).to eq("d52a6044-3a1e-4ec3-a07b-0020a34ab57f")
  end

  it 'connection must be return hash with token' do
    limelight_api = LimelightApi::Auth.new
    expect(limelight_api.connection[:token]).to eq("d52a6044-3a1e-4ec3-a07b-0020a34ab57f")
  end
end
