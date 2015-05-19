module CarrierWave
  module Storage
    class LimelightFile

      attr_reader :uploader, :connection

      def initialize(uploader, connection)
        @uploader   = uploader
        @connection = connection
      end

      def store file
        client = LimelightApi::Client.new(connection[:token])
        path = client.upload(file.file, uploader.filename, uploader.store_dir)
        @path = normalize_path(path)
      end

      def url
        uploader.asset_host + @path if uploader.asset_host && @path
      end

      def normalize_path path
        path[uploader.root_path.length .. -1]
      end
    end
  end
end
