require "rest-client"

module LimelightApi
  class Auth
    def initialize(username = ENV["LIMELIGHT_USERNAME"], password=ENV["LIMELIGHT_PASSWORD"])
      @username = username
      @password = password
      @login_endpoint = 'http://global.llp.lldns.net/jsonrpc2'
    end

    def login
      @login_response = RestClient.post( @login_endpoint, 
        request_jsonrpc('login', {username: @username, password: @password}) )
      
      if @login_response.code == 200
        @token = JSON.parse(@login_response.body)['result'].first
      else
        raise 'Limelight Login Request Failed. If the error persists, please contact your administrator.'
      end
      @login_response
    end

    def logout token = @token
      RestClient.post( @login_endpoint, request_jsonrpc('logout', {token: token}) )
    end

    def request_jsonrpc method, params, jsonrpc = '2.0'
      {
        'id' => '',
        'jsonrpc' => jsonrpc,
        'method' => method,
        'params' => params
      }.to_json
    end

    def token
      login unless @token
      @token
    end

    def connection
      {token: token}
    end
  end
end
