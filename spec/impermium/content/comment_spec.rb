require "spec_helper"
require "json"

describe "content API section" do
  describe "comment object" do
    before(:each) do
      @user_id = "whi345"
      @analyst_id = "4n4l1s7"
      @reporter_user_id = "r3p0rt3r"
      @ip = "1.1.1.1"
      @content = "a simple comment"
      @comment_id = "simple-comment-347865"
      @comment_permalink = "http://example.com/2012/03/05/just_a_comment"
      @article_permalink = "http://example.com/2012/01/05/just_a_post"
      @desired_result = {:spam_classifier => { :label => "notspam" }}
    end

    describe "comment method" do
      describe "missing arguments" do
        
        context "missing user_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.comment(nil, @comment_id, @content, @comment_permalink, @article_permalink, @ip) 
                   }.should raise_error(Impermium::BadRequest, /user_id/)
          end
        end
      
        context "missing comment_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.comment(@user_id, nil, @content, @comment_permalink, @article_permalink, @ip) 
                   }.should raise_error(Impermium::BadRequest, /comment_id/)
          end
        end
        
        context "missing content" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.comment(@user_id, @comment_id, nil, @comment_permalink, @article_permalink, @ip) 
                   }.should raise_error(Impermium::BadRequest, /content/)
          end
        end
      
        context "missing comment_permalink" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.comment(@user_id, @comment_id, @content, nil, @article_permalink, @ip) 
                   }.should raise_error(Impermium::BadRequest, /comment_permalink/)
          end
        end
      
        context "missing article_permalink" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.comment(@user_id, @comment_id, @content, @comment_permalink, nil, @ip) 
                   }.should raise_error(Impermium::BadRequest, /article_permalink/)
          end
        end

        # It's marked as mandatory in the API docs, but currently it is not.
        # context "missing enduser_ip" do
        #   use_vcr_cassette
        #   it "should raise BadRequest error" do
        #     lambda { Impermium.comment(@user_id, @comment_id, @content, @comment_permalink, @article_permalink, nil) 
        #            }.should raise_error(Impermium::BadRequest, /enduser_ip/)
        #   end
        # end
      end

      describe "successful request" do
        use_vcr_cassette
        it "should mark comment with 'notspam' label" do
          res = Impermium.comment(@user_id, @comment_id, @content, @comment_permalink, @article_permalink, @ip)
          res.spam_classifier.label.should == "notspam"
        end
      end
    end
    
    describe "comment_analyst_feedback method" do
      describe "missing arguments" do
        context "missing analyst_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.comment_analyst_feedback(nil, @comment_id, @desired_result) }.should raise_error(Impermium::BadRequest, /analyst_id/)
          end
        end
      
        context "missing comment_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.comment_analyst_feedback(@analyst_id, nil, @desired_result) }.should raise_error(Impermium::BadRequest, /comment_id/)
          end
        end
        
        context "missing desired_result" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.comment_analyst_feedback(@analyst_id, @comment_id, nil) }.should raise_error(Impermium::BadRequest, /desired_result/)
          end
        end
      end
      
      describe "successful request" do
        use_vcr_cassette
        it "should return an OK response" do
          res = Impermium.comment_analyst_feedback(@analyst_id, @comment_id, @desired_result)
          res.response_id.should be_true
          res.timestamp.should be_true
          res.status.should be_nil
          res.message.should be_nil
        end
      end
    end
    
    describe "comment_user_feedback method" do
      describe "missing arguments" do
        context "missing reporter_user_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.comment_user_feedback(nil, "MODERATOR", 
                     @ip, @comment_id, @desired_result) 
                   }.should raise_error(Impermium::BadRequest, /reporter_user_id/)
          end
        end

        context "invalid reporter_user_type" do
          use_vcr_cassette
          it "should use default value" do
            res = Impermium.comment_user_feedback(@reporter_user_id, "NOT VALID", @ip, @comment_id, @desired_result)
            res.response_id.should be
            res.timestamp.should be
            res.status.should be_nil
            res.message.should be_nil
          end
        end

        context "missing reporter_ip" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.comment_user_feedback(@reporter_user_id, "MODERATOR",
                     "", @comment_id, @desired_result)
                   }.should raise_error(Impermium::BadRequest, /reporter_ip/)
          end
        end

        context "missing comment_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.comment_user_feedback(@reporter_user_id, "MODERATOR",
                     @ip, nil, @desired_result)
                   }.should raise_error(Impermium::BadRequest, /comment_id/)
          end
        end
      
        context "missing desired_result" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.comment_user_feedback(@reporter_user_id, "MODERATOR",
                     @ip, @comment_id, nil) 
                   }.should raise_error(Impermium::BadRequest, /desired_result/)
          end
        end
      end

      describe "successful request" do
        use_vcr_cassette
        it "should return an OK response" do
          res = Impermium.comment_user_feedback(@reporter_user_id, "ENDUSER", @ip, @comment_id, @desired_result)
          res.response_id.should be
          res.timestamp.should be
          res.status.should be_nil
          res.message.should be_nil
        end
      end
    end
    
  end
end
