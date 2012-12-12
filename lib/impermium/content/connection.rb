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
      api_post("connection", options, &block)
    end
    
    def connection_analyst_feedback(analyst_id, connection_type, connection_id, desired_result, options={}, &block)
      options.merge!(
        :analyst_id => analyst_id,
        :connection_type => connection_type,
        :connection_id => connection_id,
        :desired_result => desired_result
        )
      api_post("connection/analyst_feedback", options, &block)
    end
    
    def connection_user_feedback(rep_usr_id, rep_usr_type, reporter_ip, connection_type, connection_id, desired_result, options={}, &block)
      options.merge!(
        :reporter_user_id => rep_usr_id,
        :reporter_user_type => REPORTER_USER_TYPE_VALUES.include?(rep_usr_type) ? rep_usr_type : REPORTER_USER_TYPE_VALUES.first,
        :reporter_ip => reporter_ip,
        :connection_type => connection_type,
        :connection_id => connection_id,
        :desired_result => desired_result
        )
      api_post("connection/user_feedback", options, &block)
    end
    
  end
end
