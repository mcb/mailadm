module Mailadm
  module Util
    module PathHelper
      def self.absolute_path(*relative_parts)
        root = File.expand_path('../../', File.dirname(__FILE__))
        File.join(root, *relative_parts)
      end
    end
  end
end
