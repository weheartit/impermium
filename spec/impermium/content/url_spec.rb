require "spec_helper"
require "json"

describe "content API section" do

  describe Impermium::URL do
    before(:each) do
      @user_id = "whi777"
      @analyst_id = "4n4l1s7_ID"
      @reporter_user_id = "r3p0rt3r_ID"
      @ip = "2.2.2.2"
      @url = "http://example.com/category/book/marks/33?query=whi"
      @desired_result = { :tags => [ "spam" ] }
    end

    describe "url method" do
      describe "successful request" do
        use_vcr_cassette
        it "should not be spam" do
          res = Impermium.url(@user_id, @urlurl)
          res.should_not be_spam
        end
      end
    end

    describe "url_analyst_feedback method" do
      describe "successful request" do
        use_vcr_cassette
        it "should return an OK response" do
          res = Impermium.url_analyst_feedback(@user_id, @url, @desired_result)
          res.response_id.should be_true
          res.timestamp.should be_true
        end
      end
    end

    describe "url_user_feedback method" do
      describe "successful request" do
        use_vcr_cassette
        it "should return an OK response" do
          res = Impermium.url_user_feedback(@user_id, @url, "ENDUSER", @desired_result)
          res.response_id.should be
          res.timestamp.should be
        end
      end
    end
  end
end
