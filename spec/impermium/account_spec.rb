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
      
      it "should raise BadRequest error if 'uid' is missing" do
        stub = stub_post("account/login").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'uid')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.login("", @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        stub = stub_post("account/login").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'enduser_ip')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.login(@uid_ref, "") }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "successful login request" do
      it "should return successful login response" do
        stub = stub_post("account/login").to_return(:status => 200, :body => fixture_content('login'),
          :headers => {:content_type => "application/json; charset=utf-8"})
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
      
      it "should raise BadRequest error if 'uid_ref' is missing" do
        stub = stub_post("account/profile").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'uid_ref')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.profile("", @content, @resource_url, @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        stub = stub_post("account/profile").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'enduser_ip')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.profile(@uid_ref, @content, @resource_url, "") }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "successful profile request" do
      it "should flag 'my profile content' as not profine" do
        stub = stub_post("account/profile").to_return(:status => 200, :body => fixture_content('profile'),
          :headers => {:content_type => "application/json; charset=utf-8"})
        res = Impermium.profile(@uid_ref, @content, @resource_url, @enduser_ip)
        res.profanity.confidence.should == "medium"
        res.profanity.label.should == "notprofane"
      end
    end
  end

  describe "signup API call" do
    describe "missing arguments" do
      
      it "should raise BadRequest error if 'uid' is missing" do
        stub = stub_post("account/signup").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'uid')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.signup("", @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        stub = stub_post("account/signup").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'enduser_ip')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.signup(@uid_ref, "") }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "successful signup request" do
      it "shold pass signup" do
        stub = stub_post("account/signup").to_return(:status => 200, :body => fixture_content('signup'),
          :headers => {:content_type => "application/json; charset=utf-8"})
        res = Impermium.signup(@uid_ref, @enduser_ip)
        res.spam_classifier.confidence.should == "low"
        res.spam_classifier.label.should == "spam"
      end
    end
  end

  describe "signup_attempt API call" do
    describe "missing arguments" do
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        stub = stub_post("account/signup_attempt").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'enduser_ip')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.signup_attempt("") }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "successful signup_attempt request" do
      it "shold pass signup_attempt" do
        stub = stub_post("account/signup_attempt").to_return(:status => 200, :body => fixture_content('signup_attempt'),
          :headers => {:content_type => "application/json; charset=utf-8"})
        res = Impermium.signup_attempt(@enduser_ip)
        res.etype.should == "signup_attempt"
        res.should respond_to(:ts)
      end
    end
  end
end
