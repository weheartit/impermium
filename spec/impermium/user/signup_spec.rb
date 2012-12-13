require "spec_helper"

describe Impermium::Signup do

  let(:user_id) { "whi543" }
  let(:desired_result) { {:tags => ["spam"] } }
  
  describe ".signup" do
    use_vcr_cassette

    it "should return an OK response" do
      res = Impermium.signup(user_id)
      res.response_id.should be
      res.timestamp.should be
      res.status.should_not be_nil
    end

    it "returns an instance of Impermium::Response" do
      Impermium.signup(user_id)
        .should be_a_kind_of(Impermium::Response)
    end
  end

  describe ".signup_analyst_feedback" do
    use_vcr_cassette

    it "should return an OK response" do
      res = Impermium.signup_analyst_feedback(user_id, desired_result)
      res.response_id.should be
      res.timestamp.should be
      res.status.should_not be_nil
    end

    it "returns an instance of Impermium::Response" do
      Impermium.signup_analyst_feedback(user_id, desired_result)
        .should be_a_kind_of(Impermium::Response)
    end
  end
end
