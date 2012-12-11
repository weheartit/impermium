require "spec_helper"

describe Impermium do

  let(:user_id)          { "whi345" }
  let(:message_id)       { "123456" }
  let(:message_content)  { "fuck the police" }
  let(:analyst_id)       { "4n4l1s7" }
  let(:reporter_user_id) { "r3p0rt3r" }
  let(:ip)               { "1.1.1.1" }
  let(:content)          { "just a simple post" }
  let(:post_id)          { "just-a-post#984721" }
  let(:permalink)        { "http://example.com/2012/03/05/just_a_post" }
  let(:url)              { "http://example.com" }
  let(:desired_result)   { {:spam_classifier => { :label => "notspam" }} }

  describe ".message" do
    describe "mandatory arguments" do
      context "when user_id missing" do
        use_vcr_cassette
        it "should raise BadRequest error" do
          pending "Not really mandatory"
          -> { subject.message(nil, message_id, message_content) }.should raise_error(Impermium::BadRequest, /user_id/)
        end
      end
    end
  end

  describe ".message_analyste_feedback" do
  end
end
