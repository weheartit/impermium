require "spec_helper"

describe "client configuration" do

  describe "default configuration" do
    let(:keys)   { Impermium::Configuration::VALID_CONFIG_KEYS }
    let(:client) { Impermium.new }

    it "should support current API version: 4.0" do
      client.api_version.should == '4.0'
    end

    describe "configuration attributes" do
      it "should have configuration read attributes" do
        keys.each { |key| client.respond_to?(key).should be_true }
      end

      it "should have configuration write attributes" do
        keys.each { |key| client.respond_to?("#{key}=").should be_true }
      end
      
      it "should correctly set values through attributes" do
        keys.each do |key|
          client.send("#{key}=", key)
        end
        
        keys.each do |key|
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
      client = Impermium.new(:api_key => "test_api_key")
      client.api_url(path).should include(path)
    end
  end
  
end
