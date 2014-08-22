module Mailadm
  module DB
    class Connector
      def self.host
        config[:host]
      end

      def self.db
        config[:database]
      end

      def self.protocol
        config[:protocol]
      end

      def self.credentials
        "#{config[:user]}:#{config[:password]}" if config[:user]
      end

      def self.handler
        "#{protocol}://#{credentials}@#{host}/#{db}"
      end

      def self.config
        File.open(Mailadm::Util::PathHelper.config_path, "r") { |file| YAML.load(file) }
      end
    end
  end
end


Sequel::Model.plugin(:schema)
Sequel::Model.raise_on_save_failure = false # Do not throw exceptions on failure
Sequel::Model.db = Sequel.connect(Mailadm::DB::Connector.handler, :loggers => [Logger.new($stdout)])
