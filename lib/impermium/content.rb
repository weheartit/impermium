module Impermium
  module Content
    [:blog_entry, :chatroom_message].each do |mname|
      define_method(mname) do |uid_ref, content, resource_url, enduser_ip, options={}, &block|
        options.merge!(
          :uid_ref => uid_ref,
          :content => content,
          :resource_url => resource_url,
          :enduser_ip => enduser_ip
          )
        post("content/#{mname.to_s}", options, &block)
      end
    end

    [:chat_message, :message, :wall_message].each do |mname|
      define_method(mname) do |uid_ref, uid_recv, content, enduser_ip, options={}, &block|
        options.merge!(
          :uid_ref => uid_ref,
          :uid_recv => uid_recv,
          :content => content,
          :enduser_ip => enduser_ip
          )
        post("content/#{mname.to_s}", options, &block)
      end
    end
    
    [:comment, :forum_message].each do |mname|
      define_method(mname) do |uid_ref, content, resource_url, enduser_ip, options = {}, &block|
        options.merge!(
          :uid_ref => uid_ref,
          :content => content,
          :resource_url => resource_url,
          :enduser_ip => enduser_ip
          )
        post("content/#{mname.to_s}", options, &block)
      end
    end

    def generic(uid_ref, ctype, content, resource_url, enduser_ip, options={}, &block)
      options.merge!(
        :uid_ref => uid_ref,
        :ctype => ctype,
        :content => content,
        :resource_url => resource_url,
        :enduser_ip => enduser_ip
        )
      post("content/generic", options, &block)
    end

    def rating(uid_ref, rating, enduser_ip, options={}, &block)
      raise ArgumentError, 'Rating is not in valid range' unless [1, 2, 3, 4, 5].include?(rating.to_i)
      
      options.merge!(
        :uid_ref => uid_ref,
        :rating => rating,
        :enduser_ip => enduser_ip
        )
      post("content/rating", options, &block)
    end
  end
end
