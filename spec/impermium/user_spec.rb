require "spec_helper"
require "json"

describe "user API section" do
  before(:each) do
    @user_id = "whi543"
    @ip_address = "1.1.1.1"
    @analyst_id = "123456"
    @desired_result = { :spam_classifier => { :label => "notspam" } }.to_json
  end

  describe "account method" do
    describe "missing arguments" do
      describe "missing user_id" do
        use_vcr_cassette
        it "should raise BadRequest error" do
          lambda { Impermium.account(nil, @ip_address) }.should raise_error(Impermium::BadRequest)
        end
      end
      
      describe "missing enduser_ip" do
        use_vcr_cassette
        it "should raise BadRequest error" do
          lambda { Impermium.account(@user_id, '') }.should raise_error(Impermium::BadRequest)
        end
      end
    end

    describe "successful account method request" do
      use_vcr_cassette

      it "should mark user with zero spam classifier score" do
        res = Impermium.account(@user_id, @ip_address)
        res.spam_classifier.score.to_i.should == 0
        res.spam_classifier.label.should == "notspam"
      end
    end
  end
  
  describe "account_attempt method" do
    describe "missing arguments" do
      use_vcr_cassette
      it "should raise BadRequest error if enduser_ip is missing" do
        lambda { Impermium.account_attempt('') }.should raise_error(Impermium::BadRequest)
      end
    end

    describe "successful account_attempt request" do
      use_vcr_cassette
      it "should log the attempt and return an OK response" do
        res = Impermium.account_attempt(@ip_address)
        res.response_id.should be
        res.timestamp.should be
      end
    end
  end

  describe "analystfeedback method" do
    describe "missing arguments" do
      use_vcr_cassette

      it "should raise BadRequest error if 'analyst_id' is missing" do
        lambda { Impermium.analystfeedback("", @user_id, @desired_result) }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'user_id' is missing" do
        lambda { Impermium.analystfeedback(@analyst_id, "", @desired_result) }.should raise_error(Impermium::BadRequest)
      end
    end

    describe "successful analystfeedback method request" do
      use_vcr_cassette

      it "should should be successful request" do
        res = Impermium.analystfeedback(@analyst_id, @user_id, @desired_result)
        res.response_id.start_with?("clid_boardreader").should be_true
      end
    end
  end

  describe "userfeedback method" do
    describe "missing arguments" do
      use_vcr_cassette

      it "should raise BadRequest error if 'reporter_user_id' is missing" do
        lambda { Impermium.userfeedback("", "ADMINUSER", @ip_address, @user_id, @desired_result) }.should raise_error(Impermium::BadRequest)
      end

      it "should raise BadRequest error if 'reporter_user_type' is missing" do
        lambda { Impermium.userfeedback(@user_id, "", @ip_address, @user_id, @desired_result) }.should raise_error(Impermium::BadRequest)
      end

      it "should raise BadRequest error if 'reporter_ip' is missing" do
        lambda { Impermium.userfeedback(@user_id, "ADMINUSER", "", @user_id, @desired_result) }.should raise_error(Impermium::BadRequest)
      end

      it "should raise BadRequest error if 'user_id' is missing" do
        lambda { Impermium.userfeedback(@user_id, "ADMINUSER", @ip_address, "", @desired_result) }.should raise_error(Impermium::BadRequest)
      end
    end

    describe "successful userfeedback method request" do
      use_vcr_cassette

      it "should should be successful request" do
        # res = Impermium.userfeedback("123", "ADMINUSER", @ip_address, @user_id, @desired_result)
        res = Impermium.userfeedback(@user_id, "ENDUSER", @ip_address, @user_id, @desired_result)
        res.response_id.start_with?("clid_boardreader").should be_true
      end
    end
  end
end
