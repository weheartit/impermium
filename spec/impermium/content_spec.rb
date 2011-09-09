require 'spec_helper'

describe "content API section" do
  before(:each) do
    @uid_ref = "uid_ref"
    @uid_recv = "uid_recv"
    @content = "just a comment"
    @resouce_url = "http://example.com"
    @enduser_ip = "1.1.1.1"
  end

  describe "blog_entry API call" do
    describe "missing blog_entry arguments" do
      use_vcr_cassette
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        lambda { Impermium.blog_entry(@uid_ref, @content, @resource_url, "") }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'resource_url' is missing" do
        lambda { Impermium.blog_entry(@uid_ref, @content, "", @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "successful blog_entry request" do
      use_vcr_cassette

      it "should flag 'just a comment' as not spam" do
        res = Impermium.blog_entry(@uid_ref, @content, @resource_url, @enduser_ip)
        res.spam.confidence.should == "medium"
        res.spam.label.should == "notspam"
      end
    end
  end

  describe "chat_message API call" do
    describe "missing chat_message arguments" do
      use_vcr_cassette
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        lambda { Impermium.chat_message(@uid_ref, @uid_recv, @content, "") }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'uid_recv' is missing" do
        lambda { Impermium.chat_message(@uid_ref, "", @content, @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "successful chat_message request" do
      use_vcr_cassette

      it "should flag 'just a comment' as not spam" do
        res = Impermium.chat_message(@uid_ref, @uid_recv, @content, @enduser_ip)
        res.spam.confidence.should == "medium"
        res.spam.label.should == "notspam"
      end
    end
  end

  describe "chatroom_message API call" do
    describe "missing chatroom_message arguments" do
      use_vcr_cassette
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        lambda { Impermium.chatroom_message(@uid_ref, @content, @resource_url, "") }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'resource_url' is missing" do
        lambda { Impermium.chatroom_message(@uid_ref, @content, "", @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "successful chatroom_message request" do
      use_vcr_cassette

      it "should flag 'just a comment' as not spam" do
        res = Impermium.chatroom_message(@uid_ref, @content, @resource_url, @enduser_ip)
        res.spam.confidence.should == "medium"
        res.spam.label.should == "notspam"
      end
    end
  end

  describe "comment API call" do
    describe "missing comment arguments" do
      use_vcr_cassette
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        lambda { Impermium.comment(@uid_ref, @content, @resource_url, "") }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'resource_url' is missing" do
        lambda { Impermium.comment(@uid_ref, @content, "", @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "successful comment request" do
      use_vcr_cassette

      it "should flag 'just a comment' as not spam" do
        res = Impermium.comment(@uid_ref, @content, @resource_url, @enduser_ip)
        res.spam.confidence.should == "medium"
        res.spam.label.should == "notspam"
      end
    end
  end

  describe "forum_message API call" do
    describe "missing forum_message arguments" do
      use_vcr_cassette
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        lambda { Impermium.forum_message(@uid_ref, @content, @resource_url, "") }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'resource_url' is missing" do
        lambda { Impermium.forum_message(@uid_ref, @content, "", @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "successful forum_message request" do
      use_vcr_cassette

      it "should flag 'just a comment' as not spam" do
        res = Impermium.forum_message(@uid_ref, @content, @resource_url, @enduser_ip)
        res.spam.confidence.should == "medium"
        res.spam.label.should == "notspam"
      end
    end
  end

  describe "generic API call" do
    describe "missing generic arguments" do
      use_vcr_cassette
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        lambda { Impermium.generic(@uid_ref, "api testing request", @content, @resource_url, "") }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'resource_url' is missing" do
        lambda { Impermium.generic(@uid_ref, "api testing request", @content, "", @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "successful generic request" do
      use_vcr_cassette

      it "should flag 'just a comment' as not spam" do
        res = Impermium.generic(@uid_ref, "api testing request", @content, @resource_url, @enduser_ip)
        res.spam.confidence.should == "medium"
        res.spam.label.should == "notspam"
      end
    end
  end

  describe "message API call" do
    describe "missing message arguments" do
      use_vcr_cassette
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        lambda { Impermium.message(@uid_ref, @uid_recv, @content, "") }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'uid_recv' is missing" do
        lambda { Impermium.message(@uid_ref, "", @content, @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "successful message request" do
      use_vcr_cassette

      it "should flag 'just a comment' as not spam" do
        res = Impermium.message(@uid_ref, @uid_recv, @content, @enduser_ip)
        res.spam.confidence.should == "medium"
        res.spam.label.should == "notspam"
      end
    end
  end

  describe "rating API call" do
    describe "missing rating arguments" do
      use_vcr_cassette
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        lambda { Impermium.rating(@uid_ref, 1, "") }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'uid_ref' is missing" do
        lambda { Impermium.rating("", 1, @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "bad rating value" do
      use_vcr_cassette

      it "should raise ArgumentError for invalid rating value" do
        lambda { Impermium.rating(@uid_ref, 0, @enduser_ip) }.should raise_error(ArgumentError)
      end
    end
        
    describe "successful rating request" do
      use_vcr_cassette

      it "should return simple response object" do
        res = Impermium.rating(@uid_ref, 5, @enduser_ip)
        res.should respond_to(:ts)
        res.should respond_to(:etype)
        res.should_not respond_to(:spam)
      end
    end
  end

  describe "wall_message API call" do
    describe "missing wall_message arguments" do
      use_vcr_cassette
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        lambda { Impermium.wall_message(@uid_ref, @uid_recv, @content, "") }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'uid_recv' is missing" do
        lambda { Impermium.wall_message(@uid_ref, "", @content, @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "successful wall_message request" do
      use_vcr_cassette

      it "should flag 'just a comment' as not spam" do
        res = Impermium.wall_message(@uid_ref, @uid_recv, @content, @enduser_ip)
        res.spam.confidence.should == "medium"
        res.spam.label.should == "notspam"
      end
    end
  end
end
