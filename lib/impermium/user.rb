require "impermium/user/signup"
require "impermium/user/login"
require "impermium/user/profile"

module Impermium
  module User    
    include Signup
    include Login
    include Profile
  end
end
