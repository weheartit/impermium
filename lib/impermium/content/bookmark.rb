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
    
  end
end