require "spec_helper"

describe Impermium::Post do

  before(:each) do
    @user_id = "whi345"
    @analyst_id = "4n4l1s7"
    @reporter_user_id = "r3p0rt3r"
    @ip = "1.1.1.1"
    @content = "just a simple post"
    @post_id = "just-a-post#984721"
    @desired_result = {:tags => ['spam']}
  end

  describe ".post" do
    use_vcr_cassette

    it "return ok response" do
      res = Impermium.post(@post_id, @user_id, @content)
      res.status.should eql 200
      res.should_not be_spam
    end

    it "returns an instance of Impermium::Response" do
      Impermium.post(@post_id, @user_id, @content)
        .should be_a_kind_of(Impermium::Response)
    end
  end

  describe ".post_analyst_feedback" do
    use_vcr_cassette
    it "should return an OK response" do
      res = Impermium.post_analyst_feedback(@user_id, @post_id, @desired_result)
      res.response_id.should be_true
      res.timestamp.should be_true
      res.status.should eql 200
      res.message.should be_nil
    end

    it "returns an instance of Impermium::Response" do
      Impermium.post_analyst_feedback(@user_id, @post_id, @desired_result)
        .should be_a_kind_of(Impermium::Response)
    end
  end

  describe ".post_user_feedback" do
    use_vcr_cassette
    it "should return an OK response" do
      res = Impermium.post_user_feedback(@user_id, @post_id, "ENDUSER", @desired_result)
      res.response_id.should be
      res.timestamp.should be
      res.status.should eql 200
    end

    it "returns an instance of Impermium::Response" do
      Impermium.post_user_feedback(@user_id, @post_id, "ENDUSER", @desired_result)
        .should be_a_kind_of(Impermium::Response)
    end
  end
end
