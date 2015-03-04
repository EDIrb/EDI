module EDI
  module HTTPUtilities
    require 'httparty'
    require 'uri'
    module ClassMethods
      # HTTP Requests
      def get(path, options={}, &block)
        EDI::API::Response.new HTTParty.get(path, options, &block)
      end

      def post(path, options={}, &block)
        EDI::API::Response.new HTTParty.post(path, options, &block)
      end

      def patch(path, options={}, &block)
        EDI::API::Response.new HTTParty.patch(path, options, &block)
      end

      def put(path, options={}, &block)
        EDI::API::Response.new HTTParty.put(path, options, &block)
      end

      def delete(path, options={}, &block)
        EDI::API::Response.new HTTParty.delete(path, options, &block)
      end

      def encode_uri(str)
        URI.encode(str)
      end

      def decode_uri(str)
        URI.decode(str)
      end
    end
    def self.included(base)
      base.send(:include, HTTParty)
      base.send(:extend, ClassMethods)
    end
  end
end
