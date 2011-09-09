require "spec_helper"

describe "account API section" do
  before(:each) do
    @uid_ref = "uid_ref"
    @content = "my profile content"
    @resouce_url = "http://example.com"
    @enduser_ip = "1.1.1.1"
  end

  describe "loggin API call" do
    describe "missing arguments" do
      use_vcr_cassette
      
      it "should raise BadRequest error if 'uid' is missing" do
        lambda { Impermium.login("", @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        lambda { Impermium.login(@uid_ref, "") }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "successful login request" do
      use_vcr_cassette
      
      it "should return successful login response" do
        res = Impermium.login(@uid_ref, @enduser_ip)
        res.etype.should == "login"
        res.should respond_to(:ts)
        res.should respond_to(:etype)
        res.should_not respond_to(:spam)
      end
    end
  end

  describe "profile API call" do
    describe "missing arguments" do
      use_vcr_cassette
      
      it "should raise BadRequest error if 'uid_ref' is missing" do
        lambda { Impermium.profile("", @content, @resource_url, @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        lambda { Impermium.profile(@uid_ref, @content, @resource_url, "") }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "successful profile request" do
      use_vcr_cassette
      
      it "should flag 'my profile content' as not profine" do
        res = Impermium.profile(@uid_ref, @content, @resource_url, @enduser_ip)
        res.profanity.confidence.should == "medium"
        res.profanity.label.should == "notprofane"
      end
    end
  end

  describe "signup API call" do
    describe "missing arguments" do
      use_vcr_cassette
      
      it "should raise BadRequest error if 'uid' is missing" do
        lambda { Impermium.signup("", @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        lambda { Impermium.signup(@uid_ref, "") }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "successful signup request" do
      use_vcr_cassette

      it "shold pass signup" do
        res = Impermium.signup(@uid_ref, @enduser_ip)
        res.spam_classifier.confidence.should == "low"
        res.spam_classifier.label.should == "spam"
      end
    end
  end

  describe "signup_attempt API call" do
    describe "missing arguments" do
      use_vcr_cassette
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        lambda { Impermium.signup_attempt("") }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "successful signup_attempt request" do
      use_vcr_cassette

      it "shold pass signup_attempt" do
        res = Impermium.signup_attempt(@enduser_ip)
        res.etype.should == "signup_attempt"
        res.should respond_to(:ts)
      end
    end
  end
end
