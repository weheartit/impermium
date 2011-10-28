require "spec_helper"
require "json"

describe "content API section" do
  before(:each) do
    @user_id = "whi345"
    @ip = "1.1.1.1"
    @content = "just a comment"
    @post_id = "just-a-comment#984721"
    @permalink = "http://example.com/2011/10/27/just_a_comment"
    @url = "http://example.com"
    @desired_result = { :spam_classifier => { :label => "notspam" } }.to_json
  end

  describe "blogpost API call" do
    describe "missing blogpost arguments" do
      use_vcr_cassette
      
      it "should raise BadRequest error if 'user_id' is missing" do
        lambda { Impermium.blogpost("", @post_id, @content, @permalink, @url, @ip) }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'blogpost_id' is missing" do
        lambda { Impermium.blogpost(@user_id, "", @content, @permalink, @url, @ip) }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'content' is missing" do
        lambda { Impermium.blogpost(@user_id, @post_id, "", @permalink, @url, @ip) }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'blogpost_permalink' is missing" do
        lambda { Impermium.blogpost(@user_id, @post_id, @content, "", @url, @ip) }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'blog_url' is missing" do
        lambda { Impermium.blogpost(@user_id, @post_id, @content, @permalink, "", @ip) }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        lambda { Impermium.blogpost(@user_id, @post_id, @content, @permalink, @url, "") }.should raise_error(Impermium::BadRequest)
      end
    end

    describe "successful blogpost request" do
      use_vcr_cassette

      it "should mark blog post with 'notspam' label" do
        res = Impermium.blogpost(@user_id, @post_id, @content, @permalink, @url, @ip)
        res.spam_classifier.label == "notlabel"
        res.spam_classifier.score.should be_within(0.1).of(0.0)
      end
    end
  end

  describe "bookmark API call" do
    describe "missing bookmark arguments" do
      use_vcr_cassette
      
      it "should raise BadRequest error if 'user_id' is missing" do
        lambda { Impermium.bookmark("", @post_id, @url, @ip) }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'bookmark_id' is missing" do
        lambda { Impermium.bookmark(@user_id, "", @url, @ip) }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'bookmark_url' is missing" do
        lambda { Impermium.bookmark(@user_id, @post_id, "", @ip) }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'enduser_ip' is missing" do
        lambda { Impermium.bookmark(@user_id, @post_id, @url, "") }.should raise_error(Impermium::BadRequest)
      end
    end

    describe "successful bookmark request" do
      use_vcr_cassette

      it "should mark blog post with 'notspam' label" do
        res = Impermium.bookmark(@user_id, @post_id, @url, @ip)
        res.spam_classifier.label == "notlabel"
        res.spam_classifier.score.should be_within(0.1).of(0.0)
      end
    end
  end

  describe "comment API call" do
    describe "missing comment arguments" do
      use_vcr_cassette
      
      it "should raise BadRequest error if 'user_id' is missing" do
        lambda { Impermium.comment("", "123456", @content, @permalink, @permalink, @ip) }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'comment_id' is missing" do
        lambda { Impermium.comment(@user_id, "", @content, @permalink, @permalink, @ip) }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'content' is missing" do
        lambda { Impermium.comment(@user_id, "123456", "", @permalink, @permalink, @ip) }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'comment_permalink' is missing" do
        lambda { Impermium.comment(@user_id, "123456", @content, "", @permalink, @ip) }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'article_permalink' is missing" do
        lambda { Impermium.comment(@user_id, "123456", @content, @permalink, "", @ip) }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'user_ip' is missing" do
        lambda { Impermium.comment(@user_id, "123456", @content, @permalink, @permalink, "") }.should raise_error(Impermium::BadRequest)
      end
    end

    describe "successful comment request" do
      use_vcr_cassette

      it "should mark comment with 'notspam' label" do
        res = Impermium.comment(@user_id, "123456", @content, @permalink, @permalink, @ip)
        res.spam_classifier.label == "notlabel"
        res.spam_classifier.score.should be_within(0.1).of(0.0)
      end
    end
  end

  describe "analystfeedback API call" do
    describe "missing analystfeedback arguments" do
      use_vcr_cassette
      
      it "should raise BadRequest error if 'analyst_id' is missing" do
        lambda { Impermium.content_analystfeedback("", "123456", @desired_result) }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'comment_id' is missing" do
        lambda { Impermium.content_analystfeedback(@user_id, "", @desired_result) }.should raise_error(Impermium::BadRequest)
      end
       
      it "should raise BadRequest error if 'comment_id' is missing" do
        lambda { Impermium.content_analystfeedback(@user_id, "123456", "") }.should raise_error(Impermium::BadRequest)
      end
    end

    describe "successful analystfeedback request" do
      use_vcr_cassette

      it "it should be successful request" do
        res = Impermium.content_analystfeedback(@user_id, "123456", @desired_result)
        res.response_id.start_with?("clid_boardreader").should be_true
      end
    end
  end

  describe "userfeedback API call" do
    describe "missing userfeedback arguments" do
      use_vcr_cassette
      
      it "should raise BadRequest error if 'reporter_user_id' is missing" do
        lambda { Impermium.content_userfeedback("", "ADMINUSER", @ip, @post_id, @desired_result) }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'reporter_user_type' is missing" do
        lambda { Impermium.content_userfeedback(@user_id, "", @ip, @post_id, @desired_result) }.should raise_error(Impermium::BadRequest)
      end
      
      it "should raise BadRequest error if 'reporter_ip' is missing" do
        lambda { Impermium.content_userfeedback(@user_id, "ENDUSER", "", @post_id, @desired_result) }.should raise_error(Impermium::BadRequest)
      end

      it "should raise BadRequest error if 'comment_id' is missing" do
        lambda { Impermium.content_userfeedback(@user_id, "ENDUSER", @ip, "", @desired_result) }.should raise_error(Impermium::BadRequest)
      end

      it "should raise BadRequest error if 'desired_result' is missing" do
        lambda { Impermium.content_userfeedback(@user_id, "ENDUSER", @ip, @post_id, "") }.should raise_error(Impermium::BadRequest)
      end

      it "should raise BadRequest error for invalid reporter type values" do
        lambda { Impermium.content_userfeedback(@user_id, "ADMINUSER", @ip, @post_id, @desired_result) }.should raise_error(Impermium::BadRequest)
      end
    end

    describe "successful userfeedback request" do
      use_vcr_cassette

      it "it should be successful request" do
        res = Impermium.content_userfeedback(@user_id, "ENDUSER", @ip, @post_id, @desired_result)
        res.response_id.start_with?("clid_boardreader").should be_true
      end
    end
  end
end
