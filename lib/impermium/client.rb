require "faraday"
require "faraday_middleware"
require "impermium/configuration"

module Impermium
  class Client
    include Configuration
    
    def initialize(options = {})
      options = Impermium.options.merge(options)
      Configuration::VALID_CONFIG_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    def connection
      @connection ||= Faraday.new(:url => endpoint) do |builder|
        builder.adapter adapter
        builder.use Faraday::Response::Mashify
        builder.use Faraday::Response::ParseJson
      end
    end
  end
end

