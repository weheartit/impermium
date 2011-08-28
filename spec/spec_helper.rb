require 'rspec'
require 'webmock/rspec'
require 'impermium'

def stub_post(path)
  Impermium.api_key = 'some_api'
  Impermium.endpoint = 'http://api-test.impermium.com'

  stub_request(:post, Impermium.api_url(path))
end

def fixture_content(fixture_name)
  return '' if fixture_name.nil? || fixture_name.empty?
  fixture_file = File.join(File.expand_path('..', __FILE__), 'fixtures', "#{fixture_name}.json")
  return '' unless File.exist?(fixture_file)

  File.open(fixture_file, 'r') { |f| f.read }
end
