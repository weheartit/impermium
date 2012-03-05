module Impermium
  module Bookmark

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
    
  end
end