require "impermium/user/account"
require "impermium/user/profile"

module Impermium
  module User    
    include Account
    include Profile
  end
end
