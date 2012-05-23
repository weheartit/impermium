require "spec_helper"
require "json"

describe "content API section" do
  describe "listing object" do
    before(:each) do
      @user_id = "whi231"
      @listing_id = "78912li"
      @listing_permalink = "http://example.com/listings/78912li"
      @content = "sales ad list"
      @analyst_id = "4n4l1s7"
      @reporter_user_id = "r3p0rt3r"
      @ip = "1.1.1.1"
      @desired_result = {:spam_classifier => { :label => "notspam" }}
    end

    describe "listing method" do
      describe "missing arguments" do
        
        context "missing user_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.listing(nil, @listing_id, @content, @listing_permalink, @ip) 
                   }.should raise_error(Impermium::BadRequest, /user_id/)
          end
        end
      
        context "missing listing_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.listing(@user_id, nil, @content, @listing_permalink, @ip) 
                   }.should raise_error(Impermium::BadRequest, /listing_id/)
          end
        end
        
        context "missing content" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.listing(@user_id, @listing_id, nil, @listing_permalink, @ip) 
                   }.should raise_error(Impermium::BadRequest, /content/)
          end
        end
      
        context "missing listing_permalink" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.listing(@user_id, @listing_id, @content, nil, @ip) 
                   }.should raise_error(Impermium::BadRequest, /listing_permalink/)
          end
        end
        
        context "missing enduser_ip" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.listing(@user_id, @listing_id, @content, @listing_permalink, nil) 
                   }.should raise_error(Impermium::BadRequest, /enduser_ip/)
          end
        end
      end

      describe "successful request" do
        use_vcr_cassette
        it "should mark listing with 'notspam' label" do
          res = Impermium.listing(@user_id, @listing_id, @content, @listing_permalink, @ip)
          res.spam_classifier.label.should == "notspam"
        end
      end
    end

    describe "listing_analyst_feedback method" do
      describe "missing arguments" do
        context "missing analyst_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.listing_analyst_feedback(nil, @listing_id, @desired_result) }.should raise_error(Impermium::BadRequest, /analyst_id/)
          end
        end
      
        context "missing listing_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.listing_analyst_feedback(@analyst_id, nil, @desired_result) }.should raise_error(Impermium::BadRequest, /listing_id/)
          end
        end
        
        context "missing desired_result" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.listing_analyst_feedback(@analyst_id, @listing_id, nil) }.should raise_error(Impermium::BadRequest, /desired_result/)
          end
        end
      end
      
      describe "successful request" do
        use_vcr_cassette
        it "should return an OK response" do
          res = Impermium.listing_analyst_feedback(@analyst_id, @listing_id, @desired_result)
          res.response_id.should be_true
          res.timestamp.should be_true
          res.status.should be_nil
          res.message.should be_nil
        end
      end
    end
    
    describe "listing_user_feedback method" do
      describe "missing arguments" do
        context "missing reporter_user_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.listing_user_feedback(nil, "MODERATOR", 
                     @ip, @listing_id, @desired_result) 
                   }.should raise_error(Impermium::BadRequest, /reporter_user_id/)
          end
        end

        context "invalid reporter_user_type" do
          use_vcr_cassette
          it "should use default value" do
            res = Impermium.listing_user_feedback(@reporter_user_id, "NOT VALID", @ip, @listing_id, @desired_result)
            res.response_id.should be
            res.timestamp.should be
            res.status.should be_nil
            res.message.should be_nil
          end
        end

        context "missing reporter_ip" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.listing_user_feedback(@reporter_user_id, "MODERATOR",
                     "", @listing_id, @desired_result)
                   }.should raise_error(Impermium::BadRequest, /reporter_ip/)
          end
        end

        context "missing listing_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.listing_user_feedback(@reporter_user_id, "MODERATOR",
                     @ip, nil, @desired_result)
                   }.should raise_error(Impermium::BadRequest, /listing_id/)
          end
        end
      
        context "missing desired_result" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.listing_user_feedback(@reporter_user_id, "MODERATOR",
                     @ip, @listing_id, nil) 
                   }.should raise_error(Impermium::BadRequest, /desired_result/)
          end
        end
      end

      describe "successful request" do
        use_vcr_cassette
        it "should return an OK response" do
          res = Impermium.listing_user_feedback(@reporter_user_id, "ENDUSER", @ip, @listing_id, @desired_result)
          res.response_id.should be
          res.timestamp.should be
          res.status.should be_nil
          res.message.should be_nil
        end
      end
    end
    
  end
end
