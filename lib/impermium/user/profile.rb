module Impermium
  module Profile
    REPORTER_USER_TYPE_VALUES = ["ENDUSER", "MODERATOR"] # => default first

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