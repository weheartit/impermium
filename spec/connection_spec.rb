require "spec_helper"

describe "connection API section" do
  before(:each) do
    @uid_ref = "uid_ref"
    @uid_recv = "uid_recv"
    @enduser_ip = "1.1.1.1"
  end

  describe "invite API call" do
    describe "missing invite arguments" do
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        stub = stub_post("connection/invite").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'enduser_ip')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.invite(@uid_ref, @uid_recv, "") }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'uid_recv' is missing" do
        stub = stub_post("connection/invite").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'uid_recv')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.invite(@uid_ref, "", @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "successful invite request" do
      it "should return successful response" do
        stub = stub_post("connection/invite").to_return(:status => 200, :body => fixture_content('invite'),
          :headers => {:content_type => "application/json; charset=utf-8"})
        res = Impermium.invite(@uid_ref, @uid_recv, @enduser_ip)
        res.etype.should == "invite"
      end
    end
  end

  describe "invite_response API call" do
    describe "missing invite_response arguments" do
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        stub = stub_post("connection/invite_response").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'enduser_ip')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.invite_response(@uid_ref, @uid_recv, true, "") }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'uid_ref' is missing" do
        stub = stub_post("connection/invite_response").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'uid_ref')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.invite_response(@uid_ref, @uid_recv, true, @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "successful invite_response request" do
      it "should return successful response" do
        stub = stub_post("connection/invite_response").to_return(:status => 200, :body => fixture_content('invite_response'),
          :headers => {:content_type => "application/json; charset=utf-8"})
        res = Impermium.invite_response(@uid_ref, @uid_recv, true, @enduser_ip)
        res.etype.should == "invite_response"
      end
    end
  end

end
