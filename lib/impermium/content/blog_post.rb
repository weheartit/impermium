module Impermium
  module BlogPost
    REPORTER_USER_TYPE_VALUES = ["ENDUSER", "MODERATOR"] # => default first

    def blog_post(user_id, blog_post_id, content, blog_post_permalink, blog_url, enduser_ip, options={}, &block)
      options.merge!(
        :user_id => user_id,
        :blog_post_id => blog_post_id,
        :content => content,
        :blog_post_permalink => blog_post_permalink,
        :blog_url => blog_url,
        :enduser_ip => enduser_ip
        )
      post("blog_post", options, &block)
    end
    
    def blog_post_analyst_feedback(analyst_id, blog_post_id, desired_result, options={}, &block)
      options.merge!(
        :analyst_id => analyst_id,
        :blog_post_id => blog_post_id,
        :desired_result => desired_result
        )
      post("blog_post/analyst_feedback", options, &block)
    end
    
    def blog_post_user_feedback(rep_usr_id, rep_usr_type, reporter_ip, blog_post_id, desired_result, options={}, &block)
      options.merge!(
        :reporter_user_id => rep_usr_id,
        :reporter_user_type => REPORTER_USER_TYPE_VALUES.include?(rep_usr_type) ? rep_usr_type : REPORTER_USER_TYPE_VALUES.first,
        :reporter_ip => reporter_ip,
        :blog_post_id => blog_post_id,
        :desired_result => desired_result
        )
      post("blog_post/user_feedback", options, &block)
    end
    
  end
end