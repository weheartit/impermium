module Impermium
  module Login
    def login(user_id, attempt_id, options={}, &block)
      options.merge!(:user_id => user_id, :attempt_id => attempt_id)
      api_post("login", options, &block)
    end
    
    def login_analyst_feedback(user_id, attempt_id, desired_result, options={}, &block)
      options.merge!(
        :user_id => user_id,
        :attempt_id => attempt_id,
        :desired_result => { Configuration::DEFAULT_API_VERSION => desired_result })
      api_post("login/analyst_feedback", options, &block)
    end
  end
end
