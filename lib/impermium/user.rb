module Impermium
  module User
    def account(user_id, enduser_ip, options={}, &block)
      options.merge!(
        :user_id => user_id,
        :enduser_ip => enduser_ip
        )
      post("account", options, &block)
    end
    
    def account_attempt(enduser_ip, options={}, &block)
      options.merge!(
        :enduser_ip => enduser_ip
        )
      post("account/attempt", options, &block)
    end
    
    def account_login(user_id, enduser_ip, options={}, &block)
      options.merge!(
        :user_id => user_id,
        :enduser_ip => enduser_ip
        )
      post("account/login", options, &block)
    end

    def account_analyst_feedback(analyst_id, user_id, desired_result, options={}, &block)
      options.merge!(
        :analyst_id => analyst_id,
        :user_id => user_id,
        :desired_result => desired_result
        )
      post("account/analyst_feedback", options, &block)
    end

    REPORTER_USER_TYPE_VALUES = ["ENDUSER", "MODERATOR"]
    def account_user_feedback(rep_usr_id, rep_usr_type, reporter_ip, user_id, desired_result, options={}, &block)
      options.merge!(
        :reporter_user_id => rep_usr_id,
        :reporter_user_type => REPORTER_USER_TYPE_VALUES.include?(rep_usr_type) ? rep_usr_type : "ENDUSER",
        :reporter_ip => reporter_ip,
        :user_id => user_id,
        :desired_result => desired_result
        )
      post("account/user_feedback", options, &block)
    end
    
    def profile(user_id, profile_id, enduser_ip, options={}, &block)
      options.merge!(
        :user_id => user_id,
        :profile_id => profile_id,
        :enduser_ip => enduser_ip
        )
      post("profile", options, &block)
    end
    
    def profile_analyst_feedback(profile_id, analyst_id, desired_result, options={}, &block)
      options.merge!(
        :profile_id => profile_id,
        :analyst_id => analyst_id,
        :desired_result => desired_result
        )
      post("profile/analyst_feedback", options, &block)
    end
    
    def profile_user_feedback(profile_id, rep_usr_id, rep_usr_type, reporter_ip, desired_result, options={}, &block)
      options.merge!(
        :profile_id => profile_id,
        :reporter_user_id => rep_usr_id,
        :reporter_user_type => REPORTER_USER_TYPE_VALUES.include?(rep_usr_type) ? rep_usr_type : REPORTER_USER_TYPE_VALUES.first,
        :reporter_ip => reporter_ip,
        :desired_result => desired_result
        )
      post("profile/user_feedback", options, &block)
    end
    
  end
end
