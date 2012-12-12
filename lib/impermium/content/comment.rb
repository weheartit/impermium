module Impermium
  module Comment
    REPORTER_USER_TYPE_VALUES = ["ENDUSER", "MODERATOR"] # => default first

    def comment(user_id, comment_id, content, comment_permalink, article_permalink, enduser_ip, options={}, &block)
      options.merge!(
        :user_id => user_id,
        :comment_id => comment_id,
        :content => content,
        :comment_permalink => comment_permalink,
        :article_permalink => article_permalink,
        :enduser_ip => enduser_ip
        )
      api_post("comment", options, &block)
    end
    
    def comment_analyst_feedback(analyst_id, comment_id, desired_result, options={}, &block)
      options.merge!(
        :analyst_id => analyst_id,
        :comment_id => comment_id,
        :desired_result => desired_result
        )
      api_post("comment/analyst_feedback", options, &block)
    end
    
    def comment_user_feedback(rep_usr_id, rep_usr_type, reporter_ip, comment_id, desired_result, options={}, &block)
      options.merge!(
        :reporter_user_id => rep_usr_id,
        :reporter_user_type => REPORTER_USER_TYPE_VALUES.include?(rep_usr_type) ? rep_usr_type : REPORTER_USER_TYPE_VALUES.first,
        :reporter_ip => reporter_ip,
        :comment_id => comment_id,
        :desired_result => desired_result
        )
      api_post("comment/user_feedback", options, &block)
    end
    
  end
end
