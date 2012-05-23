require "spec_helper"
require "json"

describe "content API section" do
  describe "blog_post object" do
    before(:each) do
      @user_id = "whi345"
      @analyst_id = "4n4l1s7"
      @reporter_user_id = "r3p0rt3r"
      @ip = "1.1.1.1"
      @content = "just a simple post"
      @post_id = "just-a-post#984721"
      @permalink = "http://example.com/2012/03/05/just_a_post"
      @url = "http://example.com"
      @desired_result = {:spam_classifier => { :label => "notspam" }}
    end

    describe "blog_post method" do
      describe "missing arguments" do

        context "missing user_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.blog_post(nil, @post_id, @content, @permalink, @url, @ip) }.should raise_error(Impermium::BadRequest, /user_id/)
          end
        end

        context "missing blog_post_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.blog_post(@user_id, nil, @content, @permalink, @url, @ip) }.should raise_error(Impermium::BadRequest, /blog_post_id/)
          end
        end

        context "missing content" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.blog_post(@user_id, @post_id, nil, @permalink, @url, @ip) }.should raise_error(Impermium::BadRequest, /content/)
          end
        end

        context "missing blog_post_permalink" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.blog_post(@user_id, @post_id, @content, nil, @url, @ip) }.should raise_error(Impermium::BadRequest, /blog_post_permalink/)
          end
        end

        context "missing blog_url" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.blog_post(@user_id, @post_id, @content, @permalink, nil, @ip) }.should raise_error(Impermium::BadRequest, /blog_url/)
          end
        end

        # It's marked as mandatory in the API docs, but currently it is not.
        # context "missing enduser_ip" do
        #   use_vcr_cassette
        #   it "should raise BadRequest error" do
        #     lambda { Impermium.blog_post(@user_id, @post_id, @content, @permalink, @url, nil) }.should raise_error(Impermium::BadRequest, /enduser_ip/)
        #   end
        # end
      end

      describe "successful blog_post request" do
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
        context "missing analyst_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.blog_post_analyst_feedback(nil, @post_id, @desired_result) }.should raise_error(Impermium::BadRequest, /analyst_id/)
          end
        end

        context "missing blog_post_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.blog_post_analyst_feedback(@analyst_id, nil, @desired_result) }.should raise_error(Impermium::BadRequest, /blog_post_id/)
          end
        end

        context "missing desired_result" do
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

    describe "blog_post_user_feedback method" do
      describe "missing arguments" do
        context "missing reporter_user_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.blog_post_user_feedback(nil, "MODERATOR", 
                     @ip, @post_id, @desired_result) 
                   }.should raise_error(Impermium::BadRequest, /reporter_user_id/)
          end
        end

        context "invalid reporter_user_type" do
          use_vcr_cassette
          it "should use default value" do
            res = Impermium.blog_post_user_feedback(@reporter_user_id, "NOT VALID", @ip, @post_id, @desired_result)
            res.response_id.should be
            res.timestamp.should be
            res.status.should be_nil
            res.message.should be_nil
          end
        end

        context "missing reporter_ip" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.blog_post_user_feedback(@reporter_user_id, "MODERATOR",
                     "", @post_id, @desired_result)
                   }.should raise_error(Impermium::BadRequest, /reporter_ip/)
          end
        end

        context "missing blog_post_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.blog_post_user_feedback(@reporter_user_id, "MODERATOR",
                     @ip, nil, @desired_result)
                   }.should raise_error(Impermium::BadRequest, /blog_post_id/)
          end
        end

        context "missing desired_result" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.blog_post_user_feedback(@reporter_user_id, "MODERATOR",
                     @ip, @post_id, nil) 
                   }.should raise_error(Impermium::BadRequest, /desired_result/)
          end
        end
      end

      describe "successful request" do
        use_vcr_cassette
        it "should return an OK response" do
          res = Impermium.blog_post_user_feedback(@reporter_user_id, "ENDUSER", @ip, @post_id, @desired_result)
          res.response_id.should be
          res.timestamp.should be
          res.status.should be_nil
          res.message.should be_nil
        end
      end
    end
    
  end
end
