require "spec_helper"
require "json"

describe Impermium::Profile do

  before(:each) do
    @user_id = "whi543"
    @reporter_user_id = "whi789"
    @ip_address = "1.1.1.1"
    @analyst_id = "123456"
    @profile_id = "whi543_profile"
    @desired_result = {:spam_classifier => { :label => "notspam" }}
  end

  describe ".profile" do
    use_vcr_cassette

    it "should mark user with zero spam classifier score" do
      res = Impermium.profile(@user_id, @profile_id)
      res.should_not be_spam
    end

    it "returns an instance of Impermium::Response" do
      Impermium.profile(@user_id, @profile_id)
        .should be_a_kind_of(Impermium::Response)
    end
  end
  
  describe ".profile_analyst_feedback" do
    use_vcr_cassette

    it "should return an OK response" do
      res = Impermium.profile_analyst_feedback(@profile_id, @analyst_id, @desired_result)
      res.response_id.should be
      res.timestamp.should be
      res.status.should eql 200
    end

    it "returns an instance of Impermium::Response" do
      Impermium.profile_analyst_feedback(@profile_id, @analyst_id, @desired_result)
        .should be_a_kind_of(Impermium::Response)
    end
  end
end
