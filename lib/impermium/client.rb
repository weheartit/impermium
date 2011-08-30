require "uri"
require "faraday"
require "faraday_middleware"
require "impermium/configuration"
require "impermium/content"
require "impermium/account"
require "impermium/feedback"
require "impermium/errors"
require "faraday/raise_4xx"

module Impermium
  class Client
    include Configuration
    include Account
    include Feedback
    include Content
    
    def initialize(options = {})
      options = Impermium.options.merge(options)
      Configuration::VALID_CONFIG_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    def connection
      @connection ||= Faraday.new(:url => endpoint, :headers => default_headers) do |builder|
        builder.use Faraday::Response::Mashify
        builder.use Faraday::Response::ParseJson
        builder.use Faraday::Response::Raise4xx
        builder.request :json

        builder.adapter adapter
      end
    end

    def post(url, options={})
      connection.post do |req|
        req.url api_url(url)
        req.headers['Content-Type'] = 'application/json'
        req.body = options
      end.body
    end

    def api_url(request_path, event_id = "impermium_gem_event_id_1")
      url = URI.join(endpoint,
        request_path[-1] == '/' ? request_path  : request_path + "/",
        api_version + "/",
        api_key + "/",
        event_id).to_s
    end

    private

    def default_headers
      { :http_user_agent => "Impermium Ruby Gem",
        :http_accept => "application/json"}
    end
  end
end
