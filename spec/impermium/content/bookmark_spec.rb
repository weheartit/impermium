require "spec_helper"
require "json"

describe "content API section" do
  describe "bookmark object" do
    before(:each) do
      @user_id = "whi777"
      @analyst_id = "4n4l1s7_ID"
      @reporter_user_id = "r3p0rt3r_ID"
      @ip = "2.2.2.2"
      @bookmark_id = "b00km4rk_ID"
      @bookmark_url = "http://example.com/category/book/marks/33?query=whi"
      @like_value = "1"
      @desired_result = {:spam_classifier => { :label => "notspam" }}
    end

    describe "bookmark method" do
      describe "missing arguments" do

        context "missing user_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.bookmark(nil, @bookmark_id, @bookmark_url, @ip) }.should raise_error(Impermium::BadRequest, /user_id/)
          end
        end

        context "missing bookmark_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.bookmark(@user_id, nil, @bookmark_url, @ip) }.should raise_error(Impermium::BadRequest, /bookmark_id/)
          end
        end

        context "missing bookmark_url" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.bookmark(@user_id, @bookmark_id, nil, @ip) }.should raise_error(Impermium::BadRequest, /bookmark_url/)
          end
        end

        context "missing enduser_ip" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.bookmark(@user_id, @bookmark_id, @bookmark_url, nil) }.should raise_error(Impermium::BadRequest, /enduser_ip/)
          end
        end
      end

      describe "successful request" do
        use_vcr_cassette
        it "should mark bookmark with 'notspam' label" do
          res = Impermium.bookmark(@user_id, @bookmark_id, @bookmark_url, @ip)
          res.spam_classifier.label.should == "notspam"
        end
      end
    end

    describe "bookmark_like method" do
      describe "missing arguments" do
        
        context "missing user_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.bookmark_like(nil, @bookmark_id, @bookmark_url, @like_value, @ip) }.should raise_error(Impermium::BadRequest, /user_id/)
          end
        end

        context "missing bookmark_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.bookmark_like(@user_id, nil, @bookmark_url, @like_value, @ip) }.should raise_error(Impermium::BadRequest, /bookmark_id/)
          end
        end

        context "missing bookmark_url" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.bookmark_like(@user_id, @bookmark_id, nil, @like_value, @ip) }.should raise_error(Impermium::BadRequest, /bookmark_url/)
          end
        end

        context "missing like_value" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.bookmark_like(@user_id, @bookmark_id, @bookmark_url, nil, @ip) }.should raise_error(Impermium::BadRequest, /like_value/)
          end
        end

        context "missing enduser_ip" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.bookmark_like(@user_id, @bookmark_id, @bookmark_url, @like_value, nil) }.should raise_error(Impermium::BadRequest, /enduser_ip/)
          end
        end
      end

      describe "successful request" do
        use_vcr_cassette
        it "should mark like with 'notspam' label" do
          res = Impermium.bookmark_like(@user_id, @bookmark_id, @bookmark_url, @like_value, @ip)
          res.spam_classifier.label.should == "notspam"
        end
      end
    end

    describe "bookmark_analyst_feedback method" do
      describe "missing arguments" do
        context "missing analyst_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.bookmark_analyst_feedback(nil, @bookmark_id, @desired_result) }.should raise_error(Impermium::BadRequest, /analyst_id/)
          end
        end

        context "missing bookmark_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.bookmark_analyst_feedback(@analyst_id, nil, @desired_result) }.should raise_error(Impermium::BadRequest, /bookmark_id/)
          end
        end

        context "missing desired_result" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.bookmark_analyst_feedback(@analyst_id, @bookmark_id, nil) }.should raise_error(Impermium::BadRequest, /desired_result/)
          end
        end
      end

      describe "successful request" do
        use_vcr_cassette
        it "should return an OK response" do
          res = Impermium.bookmark_analyst_feedback(@analyst_id, @bookmark_id, @desired_result)
          res.response_id.should be_true
          res.timestamp.should be_true
          res.status.should be_nil
          res.message.should be_nil
        end
      end
    end

    describe "bookmark_user_feedback method" do
      describe "missing arguments" do
        context "missing reporter_user_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.bookmark_user_feedback(nil, "MODERATOR", 
                     @ip, @bookmark_id, @desired_result) 
                   }.should raise_error(Impermium::BadRequest, /reporter_user_id/)
          end
        end

        context "invalid reporter_user_type" do
          use_vcr_cassette
          it "should use default value" do
            res = Impermium.bookmark_user_feedback(@reporter_user_id, "NOT VALID", @ip, @bookmark_id, @desired_result)
            res.response_id.should be
            res.timestamp.should be
            res.status.should be_nil
            res.message.should be_nil
          end
        end

        context "missing reporter_ip" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.bookmark_user_feedback(@reporter_user_id, "MODERATOR",
                     "", @bookmark_id, @desired_result)
                   }.should raise_error(Impermium::BadRequest, /reporter_ip/)
          end
        end

        context "missing bookmark_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.bookmark_user_feedback(@reporter_user_id, "MODERATOR",
                     @ip, nil, @desired_result)
                   }.should raise_error(Impermium::BadRequest, /bookmark_id/)
          end
        end

        context "missing desired_result" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.bookmark_user_feedback(@reporter_user_id, "MODERATOR",
                     @ip, @bookmark_id, nil) 
                   }.should raise_error(Impermium::BadRequest, /desired_result/)
          end
        end
      end

      describe "successful request" do
        use_vcr_cassette
        it "should return an OK response" do
          res = Impermium.bookmark_user_feedback(@reporter_user_id, "ENDUSER", @ip, @bookmark_id, @desired_result)
          res.response_id.should be
          res.timestamp.should be
          res.status.should be_nil
          res.message.should be_nil
        end
      end
    end
    
  end
end
