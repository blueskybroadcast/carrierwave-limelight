module LimelightApiHelper

  def limelight_api_auth
    stub_request(:post, "http://global.llp.lldns.net/jsonrpc2").
      with(:body => "{\"id\":\"\",\"jsonrpc\":\"2.0\",\"method\":\"login\",\"params\":{\"username\":\"#{ENV['LIMELIGHT_USERNAME']}\",\"password\":\"#{ENV['LIMELIGHT_PASSWORD']}\"}}",
           :headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'Content-Length'=>'103', 'User-Agent'=>'Ruby'}).
      to_return(
        :status => 200, 
        :body => "{\"jsonrpc\": \"2.0\", \"id\": \"\", \"result\": [\"d52a6044-3a1e-4ec3-a07b-0020a34ab57f\", {\"gid\": 2001069, \"uid\": 1003103}]}", 
        :headers => {
          :date=>"Tue, 26 May 2015 12:23:22 GMT",
          :content_type=>"application/json",
          :transfer_encoding=>"chunked",
          :connection=>"keep-alive",
          :access_control_allow_origin=>"*",
          :access_control_allow_headers=>"X-Agile-Authorization, X-Content-Type",
          :access_control_allow_methods=>"OPTIONS",
          :server=>"LOCS"
        }
      )
  end

  def limelight_api_client_upload_with_valid_token
    stub_request(:post, "http://global.llp.lldns.net:8080/post/raw").
      with(:body => /PNG/,
           :headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'Content-Length'=>'6803', 'User-Agent'=>'Ruby', 'X-Agile-Authorization'=>'d52a6044-3a1e-4ec3-a07b-0020a34ab57f', 'X-Agile-Basename'=>'image.png', 'X-Agile-Directory'=>'/'}
      ).to_return(
        :status => 200, 
        :body => "",
        :headers => {
          :date=>"Tue, 26 May 2015 13:33:56 GMT",
          :server=>"Apache",
          :access_control_allow_origin=>"*",
          :access_control_allow_headers=>"X-Agile-Authorization, X-Content-Type",
          :access_control_allow_methods=>"OPTIONS",
          :x_agile_status=>"0",
          :content_length=>"0",
          :x_agile_checksum=>"579fc70ad69045f84d44e27e6f9b753f976c0f340c2b88a324ddbe3af550face",
          :x_agile_size=>"6803",
          :x_agile_path=>"/username/path/image.png",
          :content_type=>"text/json;charset=utf-8"
        }
      )
  end

  def limelight_api_client_upload_with_wrong_token
    stub_request(:post, "http://global.llp.lldns.net:8080/post/raw").
      with(:body => /PNG/,
           :headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'Content-Length'=>'6803', 'User-Agent'=>'Ruby', 'X-Agile-Authorization'=>'wrong_d52a6044-3a1e-4ec3-a07b-0020a34ab57f', 'X-Agile-Basename'=>'image.png', 'X-Agile-Directory'=>'/'}
      ).to_return(
        :status => 403,
        :body => "",
        :headers => {
          :date=>"Tue, 26 May 2015 14:34:10 GMT",
          :server=>"Apache",
          :access_control_allow_origin=>"*",
          :access_control_allow_headers=>"X-Agile-Authorization, X-Content-Type",
          :access_control_allow_methods=>"OPTIONS",
          :x_agile_status=>"-10001",
          :content_length=>"0",
          :content_type=>"text/json;charset=utf-8"
        }
      )
  end
end
