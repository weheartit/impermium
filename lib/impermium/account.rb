module Impermium
  module Account
    def login(uid, enduser_ip, options={}, &block)
      options.merge!(
        :uid => uid,
        :enduser_ip => enduser_ip
        )
      post("account/login", options, &block)
    end

    def profile(uid_ref, content, resource_url, enduser_ip, options={}, &block)
      options.merge!(
        :uid_ref => uid_ref,
        :content => content,
        :resource_url => resource_url,
        :enduser_ip => enduser_ip
        )
      post("account/profile", options, &block)
    end

    def signup(uid, enduser_ip, options={}, &block)
      options.merge!(
        :uid => uid,
        :enduser_ip => enduser_ip
        )
      post("account/signup", options, &block)
    end

    def signup_attempt(enduser_ip, options={}, &block)
      options.merge!(
        :enduser_ip => enduser_ip
        )
      post("account/signup_attempt", options, &block)
    end
  end
end
