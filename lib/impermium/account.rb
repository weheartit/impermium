module Impermium
  module Account
    def login(uid, enduser_ip, options={})
      options.merge!(
        :uid => uid,
        :enduser_ip => enduser_ip
        )
      post("account/login", options)
    end

    def profile(uid_ref, content, resource_url, enduser_ip, options={})
      options.merge!(
        :uid_ref => uid_ref,
        :content => content,
        :resource_url => resource_url,
        :enduser_ip => enduser_ip
        )
      post("account/profile", options)
    end

    def signup(uid, enduser_ip, options={})
      options.merge!(
        :uid => uid,
        :enduser_ip => enduser_ip
        )
      post("account/signup", options={})
    end

    def signup_attempt(enduser_ip, options={})
      options.merge!(
        :enduser_ip => enduser_ip
        )
      post("account/signup_attempt", options)
    end
  end
end
