module Impermium
  class BaseError < StandardError
    attr_reader :request_type
    attr_reader :request_url
    
    def initialize(request_type, request_url, message)
      @request_type = request_type
      @request_url = request_url
      super message
    end
  end

  class BadRequest < BaseError
  end

  class UnauthorizedReqeust < BaseError
  end

  class ForbiddenRequest < BaseError
  end

  class NotFoundRequest < BaseError
  end

end
