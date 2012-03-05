require "impermium/content/blog_post"
require "impermium/content/bookmark"
require "impermium/content/comment"

module Impermium
  module Content
    include BlogPost
    include Bookmark
    include Comment
    
    
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
