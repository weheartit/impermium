module Impermium
  module Content
    def blog_entry(uid_ref, content, resource_url, enduser_ip, options={})
      options.merge!(
        :uid_ref => uid_ref,
        :content => content,
        :resource_url => resource_url,
        :enduser_ip => enduser_ip
        )
      post("content/blog_entry", options)
    end
    
    def chat_message(uid_ref, uid_recv, content, enduser_ip, options={})
      options.merge!(
        :uid_ref => uid_ref,
        :uid_recv => uid_recv,
        :content => content,
        :enduser_ip => enduser_ip
        )
      post("content/chat_message", options)
    end
    
    def chatroom_message(uid_ref, content, resource_url, enduser_ip, options={})
      options.merge!(
        :uid_ref => uid_ref,
        :content => content,
        :resource_url => resource_url,
        :enduser_ip => enduser_ip
        )
      post("content/chatroom_message", options)
    end
    
    def comment(uid_ref, content, resource_url, enduser_ip, options={})
      options.merge!(
        :uid_ref => uid_ref,
        :content => content,
        :resource_url => resource_url,
        :enduser_ip => enduser_ip
        )
      post("content/comment", options)
    end
  end
end
