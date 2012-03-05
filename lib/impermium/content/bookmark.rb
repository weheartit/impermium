module Impermium
  module Bookmark
    REPORTER_USER_TYPE_VALUES = ["ENDUSER", "MODERATOR"] # => default first
    
    def bookmark(user_id, bookmark_id, bookmark_url, enduser_ip, options={}, &block)
      options.merge!(
        :user_id => user_id,
        :bookmark_id => bookmark_id,
        :bookmark_url => bookmark_url,
        :enduser_ip => enduser_ip
        )
      post("bookmark", options, &block)
    end
    
    def bookmark_like(user_id, bookmark_id, bookmark_url, like_value, enduser_ip, options={}, &block)
      options.merge!(
        :user_id => user_id,
        :bookmark_id => bookmark_id,
        :bookmark_url => bookmark_url,
        :like_value => like_value,
        :enduser_ip => enduser_ip
        )
      post("bookmark/like", options, &block)
    end
    
    def bookmark_analyst_feedback(analyst_id, bookmark_id, desired_result, options={}, &block)
      options.merge!(
        :analyst_id => analyst_id,
        :bookmark_id => bookmark_id,
        :desired_result => desired_result
        )
      post("bookmark/analyst_feedback", options, &block)
    end
    
    def bookmark_user_feedback(rep_usr_id, rep_usr_type, reporter_ip, bookmark_id, desired_result, options={}, &block)
      options.merge!(
        :reporter_user_id => rep_usr_id,
        :reporter_user_type => REPORTER_USER_TYPE_VALUES.include?(rep_usr_type) ? rep_usr_type : REPORTER_USER_TYPE_VALUES.first,
        :reporter_ip => reporter_ip,
        :bookmark_id => bookmark_id,
        :desired_result => desired_result
        )
      post("bookmark/user_feedback", options, &block)
    end
    
  end
end