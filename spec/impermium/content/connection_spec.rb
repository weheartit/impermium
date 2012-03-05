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
    end
# (operation, connection_type, connection_id, requester_user_id, responder_user_id, enduser_ip, options={}, &block)       
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
    
  end
end
