require 'spec_helper'

describe "content comment events" do
  before(:each) do
    @uid_ref = "uid_ref"
    @uid_recv = "uid_recv"
    @content = "just a comment"
    @resouce_url = "http://example.com"
    @enduser_ip = "1.1.1.1"
  end

  describe "blog_entry API call" do
    describe "missing blog_entry arguments" do
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        stub = stub_post("content/blog_entry").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'enduser_ip')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.blog_entry(@uid_ref, @content, @resource_url, "") }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'resource_url' is missing" do
        stub = stub_post("content/blog_entry").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'enduser_ip')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.blog_entry(@uid_ref, @content, "", @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "successful blog_entry request" do
      it "should flag 'just a comment' as not spam" do
        stub = stub_post("content/blog_entry").to_return(:status => 200, :body => fixture_content('blog_entry'),
          :headers => {:content_type => "application/json; charset=utf-8"})
        res = Impermium.blog_entry(@uid_ref, @content, @resource_url, @enduser_ip)
        res.spam.confidence.should == "medium"
        res.spam.label.should == "notspam"
      end
    end
  end

  describe "chat_message API call" do
    describe "missing chat_message arguments" do
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        stub = stub_post("content/chat_message").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'enduser_ip')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.chat_message(@uid_ref, @uid_recv, @content, "") }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'uid_recv' is missing" do
        stub = stub_post("content/chat_message").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'enduser_ip')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.chat_message(@uid_ref, "", @content, @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "successful chat_message request" do
      it "should flag 'just a comment' as not spam" do
        stub = stub_post("content/chat_message").to_return(:status => 200, :body => fixture_content('chat_message'),
          :headers => {:content_type => "application/json; charset=utf-8"})
        res = Impermium.chat_message(@uid_ref, @uid_recv, @content, @enduser_ip)
        res.spam.confidence.should == "medium"
        res.spam.label.should == "notspam"
      end
    end
  end

  describe "chatroom_message API call" do
    describe "missing chatroom_message arguments" do
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        stub = stub_post("content/chatroom_message").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'enduser_ip')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.chatroom_message(@uid_ref, @content, @resource_url, "") }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'resource_url' is missing" do
        stub = stub_post("content/chatroom_message").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'enduser_ip')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.chatroom_message(@uid_ref, @content, "", @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "successful chatroom_message request" do
      it "should flag 'just a comment' as not spam" do
        stub = stub_post("content/chatroom_message").to_return(:status => 200, :body => fixture_content('chatroom_message'),
          :headers => {:content_type => "application/json; charset=utf-8"})
        res = Impermium.chatroom_message(@uid_ref, @content, @resource_url, @enduser_ip)
        res.spam.confidence.should == "medium"
        res.spam.label.should == "notspam"
      end
    end
  end

  describe "comment API call" do
    describe "missing comment arguments" do
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        stub = stub_post("content/comment").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'enduser_ip')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.comment(@uid_ref, @content, @resource_url, "") }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'resource_url' is missing" do
        stub = stub_post("content/comment").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'enduser_ip')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.comment(@uid_ref, @content, "", @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "successful comment request" do
      it "should flag 'just a comment' as not spam" do
        stub = stub_post("content/comment").to_return(:status => 200, :body => fixture_content('comment'),
          :headers => {:content_type => "application/json; charset=utf-8"})
        res = Impermium.comment(@uid_ref, @content, @resource_url, @enduser_ip)
        res.spam.confidence.should == "medium"
        res.spam.label.should == "notspam"
      end
    end
  end

  describe "forum_message API call" do
    describe "missing forum_message arguments" do
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        stub = stub_post("content/forum_message").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'enduser_ip')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.forum_message(@uid_ref, @content, @resource_url, "") }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'resource_url' is missing" do
        stub = stub_post("content/forum_message").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'enduser_ip')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.forum_message(@uid_ref, @content, "", @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "successful forum_message request" do
      it "should flag 'just a comment' as not spam" do
        stub = stub_post("content/forum_message").to_return(:status => 200, :body => fixture_content('forum_message'),
          :headers => {:content_type => "application/json; charset=utf-8"})
        res = Impermium.forum_message(@uid_ref, @content, @resource_url, @enduser_ip)
        res.spam.confidence.should == "medium"
        res.spam.label.should == "notspam"
      end
    end
  end

  describe "generic API call" do
    describe "missing generic arguments" do
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        stub = stub_post("content/generic").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'enduser_ip')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.generic(@uid_ref, "api testing request", @content, @resource_url, "") }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'resource_url' is missing" do
        stub = stub_post("content/generic").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'enduser_ip')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.generic(@uid_ref, "api testing request", @content, "", @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "successful generic request" do
      it "should flag 'just a comment' as not spam" do
        stub = stub_post("content/generic").to_return(:status => 200, :body => fixture_content('generic'),
          :headers => {:content_type => "application/json; charset=utf-8"})
        res = Impermium.generic(@uid_ref, "api testing request", @content, @resource_url, @enduser_ip)
        res.spam.confidence.should == "medium"
        res.spam.label.should == "notspam"
      end
    end
  end

  describe "message API call" do
    describe "missing message arguments" do
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        stub = stub_post("content/message").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'enduser_ip')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.message(@uid_ref, @uid_recv, @content, "") }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'uid_recv' is missing" do
        stub = stub_post("content/message").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'enduser_ip')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.message(@uid_ref, "", @content, @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "successful message request" do
      it "should flag 'just a comment' as not spam" do
        stub = stub_post("content/message").to_return(:status => 200, :body => fixture_content('message'),
          :headers => {:content_type => "application/json; charset=utf-8"})
        res = Impermium.message(@uid_ref, @uid_recv, @content, @enduser_ip)
        res.spam.confidence.should == "medium"
        res.spam.label.should == "notspam"
      end
    end
  end

  describe "rating API call" do
    describe "missing rating arguments" do
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        stub = stub_post("content/rating").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'enduser_ip')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.rating(@uid_ref, 1, "") }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'uid_ref' is missing" do
        stub = stub_post("content/rating").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'uid_ref')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.rating("", 1, @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "bad rating value" do
      it "should raise ArgumentError for invalid rating value" do
        stub = stub_post("content/rating").to_return(
          :status => 400,
          :body => "400",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.rating(@uid_ref, 0, @enduser_ip) }.should raise_error(ArgumentError)
      end
    end
        
    describe "successful rating request" do
      it "should return simple response object" do
        stub = stub_post("content/rating").to_return(:status => 200, :body => fixture_content('rating'),
          :headers => {:content_type => "application/json; charset=utf-8"})
        res = Impermium.rating(@uid_ref, 5, @enduser_ip)
        res.should respond_to(:ts)
        res.should respond_to(:etype)
        res.should_not respond_to(:spam)
      end
    end
  end

  describe "wall_message API call" do
    describe "missing wall_message arguments" do
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        stub = stub_post("content/wall_message").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'enduser_ip')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.wall_message(@uid_ref, @uid_recv, @content, "") }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'uid_recv' is missing" do
        stub = stub_post("content/wall_message").to_return(
          :status => 400,
          :body => "400:Unable to verify the schema of the event: (Value '' is not of type 'string' for element 'enduser_ip')",
          :headers => { :content_type => "application/json; charset=utf-u" }
          )
        lambda { Impermium.wall_message(@uid_ref, "", @content, @enduser_ip) }.should raise_error(Impermium::BadRequest)
      end
      
    end

    describe "successful wall_message request" do
      it "should flag 'just a comment' as not spam" do
        stub = stub_post("content/wall_message").to_return(:status => 200, :body => fixture_content('wall_message'),
          :headers => {:content_type => "application/json; charset=utf-8"})
        res = Impermium.wall_message(@uid_ref, @uid_recv, @content, @enduser_ip)
        res.spam.confidence.should == "medium"
        res.spam.label.should == "notspam"
      end
    end
  end

end
