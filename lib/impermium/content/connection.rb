module Impermium
  module Connection
    REPORTER_USER_TYPE_VALUES = ["ENDUSER", "MODERATOR"] # => default first
    OPERATION_VALUES          = ['request', 'response'] # => default first
    CONNECTION_TYPE_VALUES    = ['follow', 'friend']

    def connection(operation, connection_type, connection_id, requester_user_id, responder_user_id, enduser_ip, options={}, &block)
      options.merge!(
        :operation => OPERATION_VALUES.include?(operation) ? operation : OPERATION_VALUES.first,
        :connection_type => connection_type,
        :connection_id => connection_id,
        :requester_user_id => requester_user_id,
        :responder_user_id => responder_user_id,
        :enduser_ip => enduser_ip
        )
      post("connection", options, &block)
    end
    
  end
end