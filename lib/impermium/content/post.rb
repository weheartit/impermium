module Impermium
  module Post
    REPORTER_USER_TYPE_VALUES = ["ENDUSER", "MODERATOR"] # => default first

    def post(user_id, blog_post_id, content, blog_post_permalink, blog_url, enduser_ip, options={}, &block)
      options.merge!(
        :user_id => user_id,
        :blog_post_id => blog_post_id,
        :content => content,
        :blog_post_permalink => blog_post_permalink,
        :blog_url => blog_url,
        :enduser_ip => enduser_ip
        )
      api_post("post", options, &block)
    end
    
    def post_analyst_feedback(analyst_id, blog_post_id, desired_result, options={}, &block)
      options.merge!(
        :analyst_id => analyst_id,
        :blog_post_id => blog_post_id,
        :desired_result => desired_result
        )
      api_post("post/analyst_feedback", options, &block)
    end
    
    def post_user_feedback(rep_usr_id, rep_usr_type, reporter_ip, blog_post_id, desired_result, options={}, &block)
      options.merge!(
        :reporter_user_id => rep_usr_id,
        :reporter_user_type => REPORTER_USER_TYPE_VALUES.include?(rep_usr_type) ? rep_usr_type : REPORTER_USER_TYPE_VALUES.first,
        :reporter_ip => reporter_ip,
        :blog_post_id => blog_post_id,
        :desired_result => desired_result
        )
      api_post("post/user_feedback", options, &block)
    end
    
  end
end
