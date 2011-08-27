require 'faraday'

module Faraday
  class Response::Raise4xx < Response::Middleware
    def on_complete(env)
      case env[:status].to_i
      when 400
        raise Impermium::BadRequest.new(env[:method].to_s.upcase, env[:url].to_s, env[:body])
      when 401
        raise Impermium::UnauthorizedRequest.new(env[:method].to_s.upcase, env[:url].to_s, env[:body])
      when 403
        raise Impermium::ForbiddenRequest.new(env[:method].to_s.upcase, env[:url].to_s, env[:body])
      when 404
        raise Impermium::NotFoundRequest.new(env[:method].to_s.upcase, env[:url].to_s, env[:body])
      end
    end
  end
end
