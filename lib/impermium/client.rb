require "uri"
require "faraday"
require "faraday_middleware"
require "impermium/configuration"
require "impermium/content"
require "impermium/errors"
require "impermium/user"
require "faraday/raise_4xx"

module Impermium
  class Client
    include Configuration
    include Content
    include User
    
    def initialize(options = {})
      options = Impermium.options.merge(options)
      Configuration::VALID_CONFIG_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    def api_connection
      @api_connection ||= Faraday.new(:url => endpoint, :headers => default_headers) do |builder|
        builder.use Faraday::Response::Mashify
        builder.use Faraday::Response::ParseJson
        builder.use Faraday::Response::Raise4xx
        builder.request :json

        builder.adapter adapter
      end
    end

    def post(url, options={})
      api_connection.post do |req|
        req.url api_url(url)
        req.body = options
        req.headers['Content-Type'] = 'application/json'
        yield req if block_given?
      end.body
    end

    def api_url(request_path)
      url = URI.join(endpoint,
        request_path[-1] == '/' ? request_path  : request_path + "/",
        api_version + "/",
        api_key + "/").to_s
    end

    private

    def default_headers
      { :http_user_agent => "Impermium Ruby Gem",
        :http_accept => "application/json"}
    end
  end
end
