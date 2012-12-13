module Impermium
  module Message
    def message(user_id, message_id, content, options = {}, &block)
      options.merge!(
        :user_id => user_id,
        :message_id => message_id,
        :content => content
      )
      api_post('message', options, &block)
    end

    def message_analyst_feedback(user_id, message_id, desired_result, options = {}, &block)
      options.merge!(
        :user_id => user_id,
        :message_id => message_id,
        :desired_result => { Configuration::DEFAULT_API_VERSION => desired_result }
      )
      api_post('message/analyst_feedback', options, &block)
    end

    def message_user_feedback(user_id, message_id, desired_result, options = {}, &block)
      options.merge!(
        :user_id => user_id,
        :message_id => message_id,
        :desired_result => { Configuration::DEFAULT_API_VERSION => desired_result }
      )
      api_post('message/user_feedback', options, &block)
    end
  end
end
