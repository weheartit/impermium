require "impermium/content/blog_post"

module Impermium
  module Content
    include BlogPost
    
    def bookmark(user_id, bookmark_id, bookmark_url, enduser_ip, options={}, &block)
      options.merge!(
        :user_id => user_id,
        :bookmark_id => bookmark_id,
        :bookmark_url => bookmark_url,
        :enduser_ip => enduser_ip
        )
      post("content/bookmark", options, &block)
    end
    
    def comment(user_id, comment_id, content, comment_permalink, article_permalink, enduser_ip, options={}, &block)
      options.merge!(
        :user_id => user_id,
        :comment_id => comment_id,
        :content => content,
        :comment_permalink => comment_permalink,
        :article_permalink => article_permalink,
        :enduser_ip => enduser_ip
        )
      post("content/comment", options, &block)
    end
    
    def content_analystfeedback(analyst_id, comment_id, desired_result, options={}, &block)
      options.merge!(
        :analyst_id => analyst_id,
        :comment_id => comment_id,
        :desired_result => desired_result
        )
      post("content/comment/analystfeedback", options, &block)
    end
    
    def content_userfeedback(rep_usr_id, rep_usr_type, reporter_ip, comment_id, desired_result, options={}, &block)
      options.merge!(
        :reporter_user_id => rep_usr_id,
        :reporter_user_type => rep_usr_type,
        :reporter_ip => reporter_ip,
        :comment_id => comment_id,
        :desired_result => desired_result
        )
      post("content/comment/userfeedback", options, &block)
    end
  end
end
