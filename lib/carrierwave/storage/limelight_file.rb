require 'streamio-ffmpeg'

module CarrierWave
  module Storage
    class LimelightFile

      attr_reader :uploader, :connection, :file

      def initialize(uploader, connection, file)
        @uploader   = uploader
        @connection = connection
        @file = file

        duration
      end

      def store
        client = LimelightApi::Client.new(connection[:token])
        path = client.upload(@file.file, uploader.filename, uploader.store_dir)
        @path = normalize_path(path)
      end

      def url
        uploader.asset_host + @path if uploader.asset_host && @path
      end

      def media_type
        @file.content_type
      end

      def filename
        URI.decode(@path).gsub(/.*\/(.*?$)/, '\1') if @path
      end

      def media_types
        ['audio/mpeg', 'audio/wav', 'audio/x-m4a']
      end

      def duration
        @duration ||= if media_types.include?(media_type) 
          FFMPEG::Movie.new(@file.file).duration
        end
      end

      def hashed_id
      end

      def normalize_path path
        path[uploader.root_path.length .. -1]
      end
    end
  end
end
