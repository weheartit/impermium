require "spec_helper"
require "json"

describe "content API section" do
  describe "blog_post object" do
    before(:each) do
      @user_id = "whi345"
      @analyst_id = "4n4l1s7"
      @reporter_user_id = "r3p0rt3r"
      @ip = "1.1.1.1"
      @content = "just a simple post"
      @post_id = "just-a-post#984721"
      @permalink = "http://example.com/2012/03/05/just_a_post"
      @url = "http://example.com"
      @desired_result = {:spam_classifier => { :label => "notspam" }}
    end

    describe "blog_post method" do
      describe "successful blog_post request" do
        use_vcr_cassette
        it "should allow" do
          res = Impermium.blog_post(@user_id, @post_id, @content, @permalink, @url, @ip)
          res.should be_allow
        end
      end
    end

    describe "blog_post_analyst_feedback method" do
      describe "successful request" do
        use_vcr_cassette
        it "should return an OK response" do
          res = Impermium.blog_post_analyst_feedback(@analyst_id, @post_id, @desired_result)
          res.response_id.should be_true
          res.timestamp.should be_true
          res.status.should eql 200
          res.message.should be_nil
        end
      end
    end

    describe "blog_post_user_feedback method" do
      describe "successful request" do
        use_vcr_cassette
        it "should return an OK response" do
          res = Impermium.blog_post_user_feedback(@reporter_user_id, "ENDUSER", @ip, @post_id, @desired_result)
          res.response_id.should be
          res.timestamp.should be
          res.status.should eql 200
        end
      end
    end
  end
end
