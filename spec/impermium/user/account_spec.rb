require "spec_helper"
require "json"

describe "user API section" do
  describe "account object" do
    before(:each) do
      @user_id = "whi543"
      @reporter_user_id = "whi789"
      @ip_address = "1.1.1.1"
      @analyst_id = "123456"
      @profile_id = "whi543_profile"
      @desired_result = {:spam_classifier => { :label => "notspam" }}
    end
  
    describe "account method" do
      describe "missing arguments" do
        context "missing user_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.account(nil, @ip_address) }.should raise_error(Impermium::BadRequest, /user_id/)
          end
        end
      
        context "missing enduser_ip" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.account(@user_id, '') }.should raise_error(Impermium::BadRequest, /enduser_ip/)
          end
        end
        
        context "invalid enduser_ip" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.account(@user_id, '127.0.0.1') }.should raise_error(Impermium::BadRequest, /enduser_ip/)
          end
        end
      end

      describe "successful account method request" do
        use_vcr_cassette

        it "should mark user with zero spam classifier score" do
          res = Impermium.account(@user_id, @ip_address)
          res.spam_classifier.score.to_i.should == 0
          res.spam_classifier.label.should == "notspam"
        end
      end
    end
  
    describe "account_attempt method" do
      describe "missing arguments" do
        use_vcr_cassette
        it "should raise BadRequest error if enduser_ip is missing" do
          lambda { Impermium.account_attempt('') }.should raise_error(Impermium::BadRequest, /enduser_ip/)
        end
      end

      describe "successful account_attempt request" do
        use_vcr_cassette
        it "should log the attempt and return an OK response" do
          res = Impermium.account_attempt(@ip_address)
          res.response_id.should be
          res.timestamp.should be
          res.status.should be_nil
          res.message.should be_nil
        end
      end
    end
  
    describe "account_login method" do
      describe "missing arguments" do
        context "missing user_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.account_login(nil, @ip_address) }.should raise_error(Impermium::BadRequest, /user_id/)
          end
        end
      
        context "missing enduser_ip" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.account_login(@user_id, '') }.should raise_error(Impermium::BadRequest, /enduser_ip/)
          end
        end
      end

      describe "successful account_login request" do
        use_vcr_cassette
        it "should return an OK response" do
          res = Impermium.account_login(@user_id, @ip_address)
          res.response_id.should be
          res.timestamp.should be
          res.status.should be_nil
          res.message.should be_nil
        end
      end
    end

    describe "account_analyst_feedback method" do
      describe "missing arguments" do
        context "missing analyst_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.account_analyst_feedback(nil, @user_id, @desired_result) }.should raise_error(Impermium::BadRequest, /analyst_id/)
          end
        end
      
        context "missing user_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.account_analyst_feedback(@analyst_id, nil, @desired_result) }.should raise_error(Impermium::BadRequest, /user_id/)
          end
        end
      end

      describe "successful account_analyst_feedback method request" do
        use_vcr_cassette
        it "should return an OK response" do
          res = Impermium.account_analyst_feedback(@analyst_id, @user_id, @desired_result)
          res.response_id.should be_true
          res.timestamp.should be_true
          res.status.should be_nil
          res.message.should be_nil
        end
      end
    end

    describe "account_user_feedback method" do
      describe "missing arguments" do
        context "missing reporter_user_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.account_user_feedback(nil, "MODERATOR", 
                     @ip_address, @user_id, @desired_result) 
                   }.should raise_error(Impermium::BadRequest, /reporter_user_id/)
          end
        end

        context "invalid reporter_user_type" do
          use_vcr_cassette
          it "should use default value" do
            res = Impermium.account_user_feedback(@reporter_user_id, "NOT VALID", @ip_address, @user_id, @desired_result)
            res.response_id.should be
            res.timestamp.should be
            res.status.should be_nil
            res.message.should be_nil
          end
        end

        context "missing reporter_ip" do
          use_vcr_cassette
          it "should raise BadRequest" do
            lambda { Impermium.account_user_feedback(@reporter_user_id, "MODERATOR",
                     "", @user_id, @desired_result)
                   }.should raise_error(Impermium::BadRequest, /reporter_ip/)
          end
        end

        context "missing user_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.account_user_feedback(@reporter_user_id, "MODERATOR",
                     @ip_address, nil, @desired_result)
                   }.should raise_error(Impermium::BadRequest, /user_id/)
          end
        end

        context "missing desired_result" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.account_user_feedback(@reporter_user_id, "MODERATOR",
                     @ip_address, @user_id, nil) 
                   }.should raise_error(Impermium::BadRequest, /desired_result/)
          end
        end
      end

      describe "successful request" do
        use_vcr_cassette
        it "should return an OK response" do
          res = Impermium.account_user_feedback(@reporter_user_id, "ENDUSER", @ip_address, @user_id, @desired_result)
          res.response_id.should be
          res.timestamp.should be
          res.status.should be_nil
          res.message.should be_nil
        end
      end
    end
  
  end
end
