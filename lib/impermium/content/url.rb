module Impermium
  module URL
    REPORTER_USER_TYPE_VALUES = ["ENDUSER", "MODERATOR"] # => default first
    
    def url(user_id, url, options={}, &block)
      options.merge!(:user_id => user_id, :url => url)
      api_post("url", options, &block)
    end
    
    def url_analyst_feedback(user_id, url, desired_result, options={}, &block)
      options.merge!(
        :user_id => user_id || 'ANONYMOUS',
        :url => url,
        :desired_result => { Configuration::DEFAULT_API_VERSION => desired_result })
      api_post("url/analyst_feedback", options, &block)
    end
    
    def url_user_feedback(user_id, url, reporter_user_type, desired_result, options={}, &block)
      options.merge!(
        :user_id => user_id || 'ANONYMOUS',
        :url => url,
        :reporter_user_type => REPORTER_USER_TYPE_VALUES.include?(reporter_user_type) ? reporter_user_type : REPORTER_USER_TYPE_VALUES.first,
        :desired_result => { Configuration::DEFAULT_API_VERSION => desired_result })
      api_post("url/user_feedback", options, &block)
    end
    
  end
end
