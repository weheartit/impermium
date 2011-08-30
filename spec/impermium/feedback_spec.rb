require "spec_helper"

describe "feedback API section" do
  before(:each) do
    @uid_ref = "uid_ref"
    @labels = [ {:profanity_classifier => "not-profane", :other_classifier => "label2"} ]
    @feedback_origin = "impermium.gem@example.com"
    @feedback_origin_role = "ANALYST"
    @enduser_ip = "1.1.1.1"
  end

  describe "content API call" do
    describe "missing arguments" do
      
      it "should raise BadRequest error if 'eid_ref' is missing" do
        stub = stub_post("feedback/content").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'eid_ref')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.content("", @labels, @feedback_origin, @feedback_origin_role, @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'feedback_origin' is missing" do
        stub = stub_post("feedback/content").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'feedback_origin')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.content(@uid_ref, @labels, "", @feedback_origin_role, @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end

    end

    describe "feedback origin role" do
      it "should not accept invalid value" do
        ["ROLE1", "USER_ROLE", "ROLE_EDITOR"].each do |role|
          lambda { Impermium.content(@uid_ref, @labels, @feedback_origin, role, @enduser_ip) }.should raise_error(ArgumentError)
        end
      end
    end
    
    describe "successful content request" do
      it "should return successful response" do
        stub = stub_post("feedback/content").to_return(:status => 200, :body => fixture_content('content'),
          :headers => {:content_type => "application/json; charset=utf-8"})
        res = Impermium.content(@uid_ref, @labels, @feedback_origin, @feedback_origin_role, @enduser_ip)
        res.etype.should == "content"
        res.should respond_to(:ts)
        res.should respond_to(:etype)
        res.should_not respond_to(:spam)
      end
    end
  end

  describe "user API call" do
    describe "missing arguments" do
      
      it "should raise BadRequest error if 'uid_ref' is missing" do
        stub = stub_post("feedback/user").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'uid_ref')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.user("", @labels, @feedback_origin, @feedback_origin_role, @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'feedback_origin' is missing" do
        stub = stub_post("feedback/user").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'feedback_origin')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.user(@uid_ref, @labels, "", @feedback_origin_role, @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end

    end

    describe "feedback origin role" do
      it "should not accept invalid value" do
        ["ROLE1", "USER_ROLE", "ROLE_EDITOR"].each do |role|
          lambda { Impermium.content(@uid_ref, @labels, @feedback_origin, role, @enduser_ip) }.should raise_error(ArgumentError)
        end
      end
    end

    describe "successful user request" do
      it "should return successful response" do
        stub = stub_post("feedback/user").to_return(:status => 200, :body => fixture_content('user'),
          :headers => {:content_type => "application/json; charset=utf-8"})
        res = Impermium.user(@uid_ref, @labels, @feedback_origin, @feedback_origin_role, @enduser_ip)
        res.should respond_to(:etype)
        res.should respond_to(:ts)
        res.should_not respond_to(:spam)
        res.etype.should == "user_feedback"
      end
    end
  end
end
