module Impermium
  module Connection
    def invite(uid_ref, uid_recv, enduser_ip, options={}, &block)
      options.merge!(
        :uid_ref => uid_ref,
        :uid_recv => uid_recv,
        :enduser_ip => enduser_ip
        )
      post("connection/invite", options, &block)
    end

    def invite_response(uid_ref, uid_recv, response, enduser_ip, options={}, &block)
      options.merge!(
        :uid_ref => uid_ref,
        :uid_recv => uid_recv,
        :response => !!response,
        :enduser_ip => enduser_ip
        )
      post("connection/invite_response", options, &block)
    end
  end
end
