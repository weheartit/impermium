require "impermium/account/signup"
require "impermium/account/login"
require "impermium/account/profile"

module Impermium
  module Account
    include Signup
    include Login
    include Profile
  end
end
