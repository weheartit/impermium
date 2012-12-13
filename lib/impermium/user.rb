require "impermium/user/signup"
require "impermium/user/profile"

module Impermium
  module User    
    include Signup
    include Profile
  end
end
