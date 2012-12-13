require "spec_helper"

describe Impermium::Login do

  let(:user_id) { "whi543" }
  let(:desired_result) { {:tags => ["spam"] } }
  
  describe ".login" do
    use_vcr_cassette

    it "should return an OK response" do
      res = Impermium.login(user_id, 1)
      res.response_id.should be
      res.timestamp.should be
      res.status.should_not be_nil
    end

    it "returns an instance of Impermium::Response" do
      Impermium.login(user_id, 1)
        .should be_a_kind_of(Impermium::Response)
    end
  end

  describe ".login_analyst_feedback" do
    use_vcr_cassette

    it "should return an OK response" do
      res = Impermium.login_analyst_feedback(user_id, 1, desired_result)
      res.response_id.should be
      res.timestamp.should be
      res.status.should_not be_nil
    end

    it "returns an instance of Impermium::Response" do
      Impermium.login_analyst_feedback(user_id, 1, desired_result)
        .should be_a_kind_of(Impermium::Response)
    end
  end
end
