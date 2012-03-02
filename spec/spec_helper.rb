require 'rspec'
require 'impermium'
require "vcr"
require "psych"

conf_file = File.join(File.expand_path("..", __FILE__), "configuration.yml")
conf = {}
if File.exist?(conf_file)
  conf = Psych.load_file(conf_file)
  Impermium.api_key = conf[:api_key]
  Impermium.endpoint = conf[:endpoint]
else
  puts "WARNING: No configuration file found. API key must be set before tests are started"
end

VCR.config do |vcr|
  vcr.cassette_library_dir = "spec/cassettes"
  vcr.stub_with :webmock
  vcr.default_cassette_options = { :record => :once }

  vcr.before_record do |vc|
    vc.request.uri.sub!(Impermium.api_key, conf[:api_key_replacement])
  end

  vcr.before_playback do |vc|
    vc.request.uri.sub!(conf[:api_key_replacement], Impermium.api_key)
  end
end

RSpec.configure do |conf|
  conf.extend VCR::RSpec::Macros
end
