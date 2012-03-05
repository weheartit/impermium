require "spec_helper"
require "json"

describe "content API section" do
  describe "connection object" do
    before(:each) do
      @connection_id = "u236711u558749c9724392933355478"
      @requester_user_id = "u236711"
      @responder_user_id = "u558749"
      @analyst_id = "4n4l1s7cid"
      @reporter_user_id = "r3p0rt3rcid"
      @ip = "3.3.3.3"
      @desired_result = {:spam_classifier => { :label => "notspam" }}
    end

    describe "connection method" do
      describe "missing arguments" do
 
        describe "invalid operation value" do
          use_vcr_cassette
          it "should use default value and respond OK" do
            res= Impermium.connection('invalid', 'friend', @connection_id, @requester_user_id, @responder_user_id, @ip)
            res.response_id.should be_true
            res.timestamp.should be_true
            res.status.should be_nil
            res.message.should be_nil
          end
        end
        
        describe "missing connection_type" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.connection('request', nil, @connection_id, @requester_user_id, @responder_user_id, @ip)
                   }.should raise_error(Impermium::BadRequest, /connection_type/)
          end
        end
        
        describe "invalid connection_type value" do
           use_vcr_cassette
           it "should raise BadRequest error" do
             lambda { Impermium.connection('request', 'no-valid', @connection_id, @requester_user_id, @responder_user_id, @ip)
                    }.should raise_error(Impermium::BadRequest, /connection_type/)
           end
         end
      
        describe "missing connection_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.connection('request', 'friend', nil, @requester_user_id, @responder_user_id, @ip)
                   }.should raise_error(Impermium::BadRequest, /connection_id/)
          end
        end
        
        describe "missing requester_user_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.connection('request', 'friend', @connection_id, nil, @responder_user_id, @ip)
                   }.should raise_error(Impermium::BadRequest, /requester_user_id/)
          end
        end
        
        describe "missing responder_user_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.connection('request', 'friend', @connection_id, @requester_user_id, nil, @ip)
                   }.should raise_error(Impermium::BadRequest, /responder_user_id/)
          end
        end
        
        describe "missing enduser_ip" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.connection('request', 'follow', @connection_id, @requester_user_id, @responder_user_id, nil)
                   }.should raise_error(Impermium::BadRequest, /enduser_ip/)
          end
        end
      end

      describe "successful friend connection request" do
        use_vcr_cassette
        it "should return an OK response" do
          res = Impermium.connection('request', 'friend', @connection_id, @requester_user_id, @responder_user_id, @ip)
          res.response_id.should be_true
          res.timestamp.should be_true
          res.status.should be_nil
          res.message.should be_nil
        end
      end
      
      describe "successful friend connection response" do
        use_vcr_cassette
        it "should return an OK response" do
          res = Impermium.connection('response', 'friend', @connection_id, @requester_user_id, @responder_user_id, @ip)
          res.response_id.should be_true
          res.timestamp.should be_true
          res.status.should be_nil
          res.message.should be_nil
        end
      end
      
      describe "successful follow connection request" do
        use_vcr_cassette
        it "should return an OK response" do
          res = Impermium.connection('request', 'follow', @connection_id, @requester_user_id, @responder_user_id, @ip)
          res.response_id.should be_true
          res.timestamp.should be_true
          res.status.should be_nil
          res.message.should be_nil
        end
      end
      
      describe "successful follow connection response" do
        use_vcr_cassette
        it "should return an OK response" do
          res = Impermium.connection('response', 'follow', @connection_id, @requester_user_id, @responder_user_id, @ip)
          res.response_id.should be_true
          res.timestamp.should be_true
          res.status.should be_nil
          res.message.should be_nil
        end
      end
    end
    
    describe "connection_analyst_feedback method" do
      describe "missing arguments" do
        describe "missing analyst_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.connection_analyst_feedback(nil, 'friend', @connection_id, @desired_result) }.should raise_error(Impermium::BadRequest, /analyst_id/)
          end
        end
        
        describe "missing connection_type" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.connection_analyst_feedback(@analyst_id, nil, @connection_id, @desired_result) 
                   }.should raise_error(Impermium::BadRequest, /connection_type/)
          end
        end
        
        describe "invalid connection_type value" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.connection_analyst_feedback(@analyst_id, 'invalid_type', @connection_id, @desired_result) 
                   }.should raise_error(Impermium::BadRequest, /connection_type/)
          end
        end
      
        describe "missing connection_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.connection_analyst_feedback(@analyst_id, 'friend', nil, @desired_result) }.should raise_error(Impermium::BadRequest, /connection_id/)
          end
        end
        
        describe "missing desired_result" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.connection_analyst_feedback(@analyst_id, 'friend', @connection_id, nil) }.should raise_error(Impermium::BadRequest, /desired_result/)
          end
        end
      end
      
      describe "successful request" do
        use_vcr_cassette
        it "should return an OK response" do
          res = Impermium.connection_analyst_feedback(@analyst_id, 'friend', @connection_id, @desired_result)
          res.response_id.should be_true
          res.timestamp.should be_true
          res.status.should be_nil
          res.message.should be_nil
        end
      end
    end
    
    describe "connection_user_feedback method" do
      describe "missing arguments" do
        describe "missing reporter_user_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.connection_user_feedback(nil, "MODERATOR", 
                     @ip, 'follow', @connection_id, @desired_result) 
                   }.should raise_error(Impermium::BadRequest, /reporter_user_id/)
          end
        end

        describe "invalid reporter_user_type" do
          use_vcr_cassette
          it "should use default value" do
            res = Impermium.connection_user_feedback(@reporter_user_id, "NOT VALID", @ip, 'follow', @connection_id, @desired_result)
            res.response_id.should be
            res.timestamp.should be
            res.status.should be_nil
            res.message.should be_nil
          end
        end

        describe "missing reporter_ip" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.connection_user_feedback(@reporter_user_id, "MODERATOR",
                     "", 'follow', @connection_id, @desired_result)
                   }.should raise_error(Impermium::BadRequest, /reporter_ip/)
          end
        end

        describe "missing connection_type" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.connection_user_feedback(@reporter_user_id, "MODERATOR",
                     @ip, nil, @connection_id, @desired_result)
                   }.should raise_error(Impermium::BadRequest, /connection_type/)
          end
        end
        
        describe "invalid connection_type value" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.connection_user_feedback(@reporter_user_id, "MODERATOR",
                     @ip, 'wrong_type', @connection_id, @desired_result)
                   }.should raise_error(Impermium::BadRequest, /connection_type/)
          end
        end

        describe "missing connection_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.connection_user_feedback(@reporter_user_id, "MODERATOR",
                     @ip, 'follow', nil, @desired_result)
                   }.should raise_error(Impermium::BadRequest, /connection_id/)
          end
        end
      
        describe "missing desired_result" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.connection_user_feedback(@reporter_user_id, "MODERATOR",
                     @ip, 'follow', @connection_id, nil) 
                   }.should raise_error(Impermium::BadRequest, /desired_result/)
          end
        end
      end

      describe "successful request" do
        use_vcr_cassette
        it "should return an OK response" do
          res = Impermium.connection_user_feedback(@reporter_user_id, "ENDUSER", @ip, 'follow', @connection_id, @desired_result)
          res.response_id.start_with?("CLID").should be_true
          res.response_id.should be
          res.timestamp.should be
          res.status.should be_nil
        end
      end
    end
    
  end
end
