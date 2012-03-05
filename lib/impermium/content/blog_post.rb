module Impermium
  module BlogPost
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
    
  end
end