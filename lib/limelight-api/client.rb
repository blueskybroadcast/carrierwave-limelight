require 'rest-client'

module LimelightApi
  class Client
    def initialize(token)
      @token = token
      @upload_endpoint = 'http://global.llp.lldns.net:8080/post/raw'
      @jsonrpc_endpoint = 'http://global.llp.lldns.net:8080/jsonrpc2'
    end

    def upload file_path, file_base_name = nil, directory = nil, tries = 2
      begin
        file_base_name = file_path.split('/').last unless file_base_name
        @last_uploaded_file = RestClient.post( @upload_endpoint, get_file(file_path), upload_headers(file_base_name, directory) )
        @last_uploaded_file.headers[:x_agile_path]
      rescue RestClient::Forbidden => e
        Rails.logger.warn "Limelight Upload Response Forbidden, #{e.message}, (response headers: #{e.response.headers})"
        Rails.logger.warn e.response

        if (tries -= 1) > 0
          @token = get_new_token
          retry
        else
          raise e
        end
      end
    end

    def last_uploaded_file
      @last_uploaded_file
    end

    def move_file filepath, newpath
      @make_dir_response = RestClient.post(@jsonrpc_endpoint,
                                           request_jsonrpc('rename', {token: @token, oldpath: filepath, newpath: newpath}))
    rescue RestClient::ExceptionWithResponse => e
      Rails.logger.warn 'Limelight rename JSONRPC Request FAILED:'
      Rails.logger.warn e.message
      Rails.logger.warn e.response
    end

    def make_dir path
      @make_dir_response = RestClient.post(@jsonrpc_endpoint,
                                           request_jsonrpc('makeDir2', {token: @token, path: path}))
    rescue RestClient::ExceptionWithResponse => e
      Rails.logger.warn 'Limelight makeDir2 JSONRPC Request FAILED:'
      Rails.logger.warn e.message
      Rails.logger.warn e.response
    end

    def delete_file path
      @delete_file_response = RestClient.post( @jsonrpc_endpoint,
                                               request_jsonrpc('deleteFile', {token: @token, path: path}) )
    rescue RestClient::ExceptionWithResponse => e
      Rails.logger.warn 'Limelight deleteFile JSONRPC Request FAILED:'
      Rails.logger.warn e.message
      Rails.logger.warn e.response
    end

    def list_file path
      @list_file_response = RestClient.post( @jsonrpc_endpoint,
                                             request_jsonrpc('listFile', {token: @token, path: path}) )
    rescue RestClient::ExceptionWithResponse => e
      Rails.logger.warn 'Limelight listFile JSONRPC Request FAILED:'
      Rails.logger.warn e.message
      Rails.logger.warn e.response
    end

    private

    def get_new_token
      LimelightApi::Auth.new.token
    end

    def request_jsonrpc method, params, jsonrpc = '2.0'
      {
        'id' => Time.now.to_f.to_s,
        'jsonrpc' => jsonrpc,
        'method' => method,
        'params' => params
      }.to_json
    end

    def upload_headers file_base_name, directory
      {
        'X-Agile-Authorization' => @token,
        'X-Agile-Basename' => file_base_name,
        'X-Agile-Directory' => "#{directory}/"
      }
    end

    def get_file file_path
      File.open(file_path, 'rb')
    end
  end
end
