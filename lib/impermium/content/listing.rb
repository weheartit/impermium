module Impermium
  module Listing
    REPORTER_USER_TYPE_VALUES = ["ENDUSER", "MODERATOR"] # => default first

    def listing(user_id, listing_id, content, listing_permalink, enduser_ip, options={}, &block)
      options.merge!(
        :user_id => user_id,
        :listing_id => listing_id,
        :content => content,
        :listing_permalink => listing_permalink,
        :enduser_ip => enduser_ip
        )
      api_post("listing", options, &block)
    end
    
    def listing_analyst_feedback(analyst_id, listing_id, desired_result, options={}, &block)
      options.merge!(
        :analyst_id => analyst_id,
        :listing_id => listing_id,
        :desired_result => desired_result
        )
      api_post("listing/analyst_feedback", options, &block)
    end
    
    def listing_user_feedback(rep_usr_id, rep_usr_type, reporter_ip, listing_id, desired_result, options={}, &block)
      options.merge!(
        :reporter_user_id => rep_usr_id,
        :reporter_user_type => REPORTER_USER_TYPE_VALUES.include?(rep_usr_type) ? rep_usr_type : REPORTER_USER_TYPE_VALUES.first,
        :reporter_ip => reporter_ip,
        :listing_id => listing_id,
        :desired_result => desired_result
        )
      api_post("listing/user_feedback", options, &block)
    end
    
  end
end
