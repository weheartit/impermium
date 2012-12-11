module Impermium
  module Configuration
    VALID_CONFIG_KEYS = [
      :adapter,
      :api_version,
      :api_key,
      :client_name,
      :client_id,
      :endpoint
    ].freeze

    DEFAULT_ADAPTER = :net_http
    DEFAULT_API_VERSION = "4.0"
    DEFAULT_API_KEY = nil
    DEFAULT_CLIENT_NAME = nil
    DEFAULT_CLIENT_ID = nil
    DEFAULT_ENDPOINT = "http://api.impermium.com"
    
    attr_accessor *VALID_CONFIG_KEYS

    def self.extended(base)
      base.reset
    end

    def configure
      yield self
    end

    def options
      options = {}
      VALID_CONFIG_KEYS.each { |key| options[key] = send(key) }
      options
    end
    
    def reset
      self.adapter = DEFAULT_ADAPTER
      self.api_version = DEFAULT_API_VERSION
      self.api_key = DEFAULT_API_KEY
      self.client_name = DEFAULT_CLIENT_NAME
      self.client_id = DEFAULT_CLIENT_ID
      self.endpoint = DEFAULT_ENDPOINT
    end
  end
end
