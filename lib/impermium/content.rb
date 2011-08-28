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

    def comment(uid_ref, content, resource_url, enduser_ip, options={})
      options[:uid_ref] = uid_ref
      options[:content] = content
      options[:resource_url] = resource_url
      options[:enduser_ip] = enduser_ip
      post("content/comment", options)
    end
  end
end
