require "spec_helper"

describe Impermium::Signup do

  before(:each) do
    @user_id = "whi543"
    @reporter_user_id = "whi789"
    @ip_address = "1.1.1.1"
    @analyst_id = "123456"
    @profile_id = "whi543_profile"
    @desired_result = {:tags => ["spam"] }
  end
  
  describe ".signup" do
    use_vcr_cassette

    it "should return an OK response" do
      res = Impermium.signup(@user_id)
      res.response_id.should be
      res.timestamp.should be
      res.status.should_not be_nil
    end
  end
end
