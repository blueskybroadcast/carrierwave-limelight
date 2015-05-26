require 'spec_helper'

describe LimelightApi::Client do
  include LimelightApiHelper

  before do
    limelight_api_auth
    limelight_api_client_upload_with_valid_token
    limelight_api_client_upload_with_wrong_token
  end

  it 'upload file with valid token' do
    token = LimelightApi::Auth.new.token
    client = LimelightApi::Client.new token
    file = client.upload('spec/support/fixtures/image.png')
    expect(file).to eq("/username/path/image.png")
  end

  it 'upload file with wrong token' do
    token = LimelightApi::Auth.new.token
    client = LimelightApi::Client.new "wrong_#{token}"
    file = client.upload('spec/support/fixtures/image.png')
    expect(file).to eq("/username/path/image.png")
  end
end
