require "spec_helper"
require "json"

describe "user API section" do
  describe "profile object" do
    before(:each) do
      @user_id = "whi543"
      @reporter_user_id = "whi789"
      @ip_address = "1.1.1.1"
      @analyst_id = "123456"
      @profile_id = "whi543_profile"
      @desired_result = {:spam_classifier => { :label => "notspam" }}
    end

    describe "profile method" do
      describe "missing arguments" do
        context "missing user_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.profile(nil, @profile_id, @ip_address) }.should raise_error(Impermium::BadRequest, /user_id/)
          end
        end
      
        context "missing profile_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.profile(@user_id, nil, @ip_address) }.should raise_error(Impermium::BadRequest, /profile_id/)
          end
        end
      
        context "missing enduser_ip" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.profile(@user_id, @profile_id, '') }.should raise_error(Impermium::BadRequest, /enduser_ip/)
          end
        end
      end

      describe "successful request" do
        use_vcr_cassette
        it "should mark user with zero spam classifier score" do
          res = Impermium.profile(@user_id, @profile_id, @ip_address)
          res.spam_classifier.score.to_i.should == 0
          res.spam_classifier.label.should == "notspam"
        end
      end
    end
  
    describe "profile_analyst_feedback method" do
      describe 'missing params' do
        context "missing profile_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { 
              Impermium.profile_analyst_feedback(nil, @analyst_id, @desired_result) 
            }.should raise_error(Impermium::BadRequest, /profile_id/)
          end
        end
      
        context "missing analyst_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { 
              Impermium.profile_analyst_feedback(@profile_id, nil, @desired_result) 
            }.should raise_error(Impermium::BadRequest, /analyst_id/)
          end
        end
      
        context "missing desired_result" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { 
              Impermium.profile_analyst_feedback(@profile_id, @analyst_id, nil)
            }.should raise_error(Impermium::BadRequest, /desired_result/)
          end
        end
      
      end
      describe "successful request" do
        use_vcr_cassette
        it "should return an OK response" do
          res = Impermium.profile_analyst_feedback(@profile_id, @analyst_id, @desired_result)
          res.response_id.should be
          res.timestamp.should be
          res.status.should be_nil
          res.message.should be_nil
        end
      end
    end
  
    describe "profile_user_feedback method" do
      describe "missing arguments" do
        context "missing profile_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.profile_user_feedback(nil, @reporter_user_id,
                    "MODERATOR", @ip_address, @desired_result) 
                   }.should raise_error(Impermium::BadRequest, /profile_id/)
          end
        end
      
        context "missing reporter_user_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.profile_user_feedback(@profile_id, nil, 
                     "MODERATOR", @ip_address, @desired_result) 
                   }.should raise_error(Impermium::BadRequest, /reporter_user_id/)
          end
        end

        context "invalid reporter_user_type" do
          use_vcr_cassette
          it "should use default value" do
            res = Impermium.profile_user_feedback(@profile_id, @reporter_user_id, "NOT VALID", @ip_address, @desired_result)
            res.response_id.should be
            res.timestamp.should be
            res.status.should be_nil
            res.message.should be_nil
          end
        end

        context "missing reporter_ip" do
          use_vcr_cassette
          it "should raise BadRequest" do
            lambda { Impermium.profile_user_feedback(@profile_id, @reporter_user_id,
                     "MODERATOR", "", @desired_result)
                   }.should raise_error(Impermium::BadRequest, /reporter_ip/)
          end
        end
      
        context "missing desired_result" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.profile_user_feedback(@profile_id, @reporter_user_id,
                     "MODERATOR", @ip_address, nil) 
                   }.should raise_error(Impermium::BadRequest, /desired_result/)
          end
        end
      end

      describe "successful request" do
        use_vcr_cassette
        it "should return an OK response" do
          res = Impermium.profile_user_feedback(@profile_id, @reporter_user_id, "ENDUSER", @ip_address, @desired_result)
          res.response_id.should be
          res.timestamp.should be
          res.status.should be_nil
          res.message.should be_nil
        end
      end
    end
  
  end
end
