require "spec_helper"
require "json"

describe "content API section" do
  describe "blog_post object" do
    before(:each) do
      @user_id = "whi345"
      @analyst_id = "4n4l1s7"
      @ip = "1.1.1.1"
      @content = "just a post"
      @post_id = "just-a-post#984721"
      @permalink = "http://example.com/2011/10/27/just_a_post"
      @url = "http://example.com"
      @desired_result = {:spam_classifier => { :label => "notspam" }}
    end

    describe "blog_post method" do
      describe "missing arguments" do
        
        describe "missing user_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.blog_post(nil, @post_id, @content, @permalink, @url, @ip) }.should raise_error(Impermium::BadRequest)
          end
        end
      
        describe "missing blog_post_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.blog_post(@user_id, nil, @content, @permalink, @url, @ip) }.should raise_error(Impermium::BadRequest)
          end
        end
        
        describe "missing content" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.blog_post(@user_id, @post_id, nil, @permalink, @url, @ip) }.should raise_error(Impermium::BadRequest)
          end
        end
      
        describe "missing blog_post_permalink" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.blog_post(@user_id, @post_id, @content, nil, @url, @ip) }.should raise_error(Impermium::BadRequest)
          end
        end
      
        describe "missing blog_url" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.blog_post(@user_id, @post_id, @content, @permalink, nil, @ip) }.should raise_error(Impermium::BadRequest)
          end
        end
        
        describe "missing enduser_ip" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.blog_post(@user_id, @post_id, @content, @permalink, @url, nil) }.should raise_error(Impermium::BadRequest)
          end
        end
      end

      describe "successful blogpost request" do
        use_vcr_cassette
        it "should mark blog post with 'notspam' label" do
          res = Impermium.blog_post(@user_id, @post_id, @content, @permalink, @url, @ip)
          res.spam_classifier.label.should == "notspam"
          res.spam_classifier.score.to_f.should < 0.4
        end
      end
    end
    
    describe "blog_post_analyst_feedback method" do
      describe "missing arguments" do
        describe "missing analyst_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.blog_post_analyst_feedback(nil, @post_id, @desired_result) }.should raise_error(Impermium::BadRequest, /analyst_id/)
          end
        end
      
        describe "missing blog_post_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.blog_post_analyst_feedback(@analyst_id, nil, @desired_result) }.should raise_error(Impermium::BadRequest, /blog_post_id/)
          end
        end
        
        describe "missing desired_result" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.blog_post_analyst_feedback(@analyst_id, @post_id, nil) }.should raise_error(Impermium::BadRequest, /desired_result/)
          end
        end
      end
      
      describe "successful request" do
        use_vcr_cassette
        it "should return an OK response" do
          res = Impermium.blog_post_analyst_feedback(@analyst_id, @post_id, @desired_result)
          res.response_id.should be_true
          res.timestamp.should be_true
          res.status.should be_nil
          res.message.should be_nil
        end
      end
    end
    
  end
end
