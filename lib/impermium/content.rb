module Impermium
  module Content
    def comment(uid_ref, content, resource_url, enduser_ip, options={})
      options[:uid_ref] = uid_ref
      options[:content] = content
      options[:resource_url] = resource_url
      options[:enduser_ip] = enduser_ip
      post("content/comment", options)
    end
  end
end
