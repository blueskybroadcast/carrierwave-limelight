module CarrierWave
  module Storage
    class Limelight < Abstract
      def self.connection_cache
        @connection_cache ||= {}
      end

      def self.clear_connection_cache!
        @connection_cache = {}
      end

      def store!(file)
        LimelightFile.new(uploader, connection, file).tap do |limelight_file|
          limelight_file.store
        end
      end

      def connection
        @connection ||= begin
          self.class.connection_cache[credentials] ||= LimelightApi::Auth.new(
            credentials[:limelight_username],
            credentials[:limelight_password]
          ).connection
        end
      end

      def credentials
        uploader.limelight_credentials
      end
    end
  end
end
