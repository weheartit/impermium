require "spec_helper"

describe Impermium::Message do

  let(:user_id)          { "whi345" }
  let(:message_id)       { "123456" }
  let(:message_content)  { "fuck the police" }
  let(:analyst_id)       { "4n4l1s7" }
  let(:content)          { "just a simple post" }
  let(:desired_result)   { {:tags => [ "spam" ]} }

  describe ".message" do
    use_vcr_cassette

    it "returns an instance of Impermium::Response" do
      Impermium.message(@user_id, @message_id, @message_content)
        .should be_a_kind_of(Impermium::Response)
    end
  end

  describe ".message_analyst_feedback" do
    use_vcr_cassette

    it "returns an instance of Impermium::Response" do
      Impermium.message_analyst_feedback(@user_id, @message_id, @desired_result)
        .should be_a_kind_of(Impermium::Response)
    end
  end

  describe ".message_user_feedback" do
    use_vcr_cassette

    it "returns an instance of Impermium::Response" do
      Impermium.message_user_feedback(@user_id, @message_id, @desired_result)
        .should be_a_kind_of(Impermium::Response)
    end
  end
end
