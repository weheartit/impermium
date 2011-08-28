require "spec_helper"

describe "client configuration" do

  describe "default configuration" do
    before(:each) do
      @keys = Impermium::Configuration::VALID_CONFIG_KEYS
    end

    describe "configuration attributes" do
      it "should have configuration read attributes" do
        client = Impermium.new
        @keys.each { |key| client.respond_to?(key).should be_true }
      end

      it "should have configuration write attributes" do
        client = Impermium.new
        @keys.each { |key| client.respond_to?("#{key}=").should be_true }
      end
      
      it "should correctly set values through attributes" do
        client = Impermium.new
        @keys.each do |key|
          client.send("#{key}=", key)
        end
        
        @keys.each do |key|
          client.send(key).should == key
        end
      end
    end

    describe "through initialization" do
      before(:each) do
        @config = {
          :adapter => "some_adapter",
          :api_version => "0.1",
          :api_key => "impermium_key_001",
          :client_name => "Impermium Client",
          :client_id => "Client ID",
          :endpoint => "http://our.test.endpoint.com"
        }
      end

      it "should set values to those passed during initialization" do
        client = Impermium::Client.new(@config)
        @config.each do |k, v|
          client.send("#{k}").should == v
        end
      end
    end
  end

  describe "URL composing" do
    it "should contain passed path in the api URL" do
      path = "some/request/path/"
      Impermium.api_key = "api_key"
      Impermium.api_url(path).should include(path)
    end
  end
  
end
