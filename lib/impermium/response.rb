# Tiny response wrapper to hide some wiredness of the API
module Impermium
  class Response
    def initialize(response)
      @response = response
      @data = response[Impermium::Configuration::DEFAULT_API_VERSION]
    end

    %w(allow challege moderate block).each do |action|
      define_method("#{action}?") do
        action?(action)
      end
    end

    def action?(action)
      @data.action == action.to_s
    end

    def tags
      @data.tags
    end

    def tag(name)
      @data.tag_details[name]
    end

    def method_missing(name)
      @response.send(name)
    end
  end
end
