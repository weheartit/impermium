module Impermium
  module Feedback
    def content(eid_ref, labels, feedback_origin, feedback_origin_role, enduser_ip, options={})
      raise ArgumentError unless ["ANALYST", "ENDUSER", "EDITOR"].include? feedback_origin_role

      options.merge!(
        :eid_ref => eid_ref,
        :labels => labels,
        :feedback_origin => feedback_origin,
        :feedback_origin_role => feedback_origin_role,
        :enduser_ip => enduser_ip
        )
      post("feedback/content", options)
    end

    def user(uid_ref, labels, feedback_origin, feedback_origin_role, enduser_ip, options={})
      raise ArgumentError unless ["ANALYST", "ENDUSER", "EDITOR"].include? feedback_origin_role

      options.merge!(
        :uid_ref => uid_ref,
        :labels => labels,
        :feedback_origin => feedback_origin,
        :feedback_origin_role => feedback_origin_role,
        :enduser_ip => enduser_ip
        )
      post("feedback/user", options)
    end
  end
end
