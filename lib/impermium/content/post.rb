module Impermium
  module Post
    REPORTER_USER_TYPE_VALUES = ["ENDUSER", "MODERATOR"] # => default first

    def post(post_id, user_id, content, options={}, &block)
      options.merge!(:user_id => user_id, :post_id => post_id, :content => content)
      api_post("post", options, &block)
    end
    
    def post_analyst_feedback(user_id, post_id, desired_result, options={}, &block)
      options.merge!(
        :user_id => user_id,
        :post_id => post_id,
        :desired_result => { Configuration::DEFAULT_API_VERSION => desired_result }
      )
      api_post("post/analyst_feedback", options, &block)
    end
    
    def post_user_feedback(user_id, post_id, rep_usr_type, desired_result, options={}, &block)
      options.merge!(
        :user_id => user_id,
        :post_id => post_id,
        :reporter_user_type => REPORTER_USER_TYPE_VALUES.include?(rep_usr_type) ? rep_usr_type : REPORTER_USER_TYPE_VALUES.first,
        :desired_result => { Configuration::DEFAULT_API_VERSION => desired_result }
      )
      api_post("post/user_feedback", options, &block)
    end
    
  end
end
