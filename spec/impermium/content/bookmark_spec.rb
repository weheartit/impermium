require "spec_helper"
require "json"

describe "content API section" do
  describe "bookmark object" do
    before(:each) do
      @user_id = "whi777"
      @ip = "2.2.2.2"
      @bookmark_id = "b00km4rk_ID"
      @bookmark_url = "http://example.com/category/book/marks/33?query=whi"
    end
    
    describe "bookmark method" do
      describe "missing arguments" do
        
        describe "missing user_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.bookmark(nil, @bookmark_id, @bookmark_url, @ip) }.should raise_error(Impermium::BadRequest, /user_id/)
          end
        end
      
        describe "missing bookmark_id" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.bookmark(@user_id, nil, @bookmark_url, @ip) }.should raise_error(Impermium::BadRequest, /bookmark_id/)
          end
        end
      
        describe "missing bookmark_url" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.bookmark(@user_id, @bookmark_id, nil, @ip) }.should raise_error(Impermium::BadRequest, /bookmark_url/)
          end
        end
        
        describe "missing enduser_ip" do
          use_vcr_cassette
          it "should raise BadRequest error" do
            lambda { Impermium.bookmark(@user_id, @bookmark_id, @bookmark_url, nil) }.should raise_error(Impermium::BadRequest, /enduser_ip/)
          end
        end
      end

      describe "successful request" do
        use_vcr_cassette
        it "should mark bookmark post with 'notspam' label" do
          res = Impermium.bookmark(@user_id, @bookmark_id, @bookmark_url, @ip)
          res.spam_classifier.label.should == "notspam"
        end
      end
    end
    
  end
end
