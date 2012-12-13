module Impermium
  module Signup
    def signup(user_id, options={}, &block)
      options.merge!(:user_id => user_id)
      api_post("signup", options, &block)
    end
    
    def signup_analyst_feedback(user_id, desired_result, options={}, &block)
      options.merge!(
        :user_id => user_id || 'ANONYMOUS',
        :desired_result => { Configuration::DEFAULT_API_VERSION => desired_result })
      api_post("signup/analyst_feedback", options, &block)
    end
  end
end
