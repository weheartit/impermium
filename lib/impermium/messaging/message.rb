module Impermium
  module Message
    def message(user_id, message_id, content, options = {}, &block)
      options.merge!(
        :user_id => user_id,
        :message_id => message_id,
        :content => content
      )
      post('message', options, &block)
    end
  end
end
