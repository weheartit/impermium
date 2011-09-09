require "spec_helper"

describe "connection API section" do
  before(:each) do
    @uid_ref = "uid_ref"
    @uid_recv = "uid_recv"
    @enduser_ip = "1.1.1.1"
  end

  describe "invite API call" do
    describe "missing invite arguments" do
      use_vcr_cassette
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        lambda { Impermium.invite(@uid_ref, @uid_recv, "") }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'uid_recv' is missing" do
        lambda { Impermium.invite(@uid_ref, "", @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "successful invite request" do
      use_vcr_cassette
      
      it "should return successful response" do
        res = Impermium.invite(@uid_ref, @uid_recv, @enduser_ip)
        res.etype.should == "invite"
      end
    end
  end

  describe "invite_response API call" do
    describe "missing invite_response arguments" do
      use_vcr_cassette
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        lambda { Impermium.invite_response(@uid_ref, @uid_recv, true, "") }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'uid_ref' is missing" do
        lambda { Impermium.invite_response(@uid_ref, @uid_recv, true, @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "successful invite_response request" do
      use_vcr_cassette

      it "should return successful response" do
        res = Impermium.invite_response(@uid_ref, @uid_recv, true, @enduser_ip)
        res.etype.should == "invite_response"
      end
    end
  end
end
