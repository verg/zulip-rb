require 'vcr'

VCR.configure do |config|
  config.allow_http_connections_when_no_cassette = true
  config.ignore_localhost = true
  config.cassette_library_dir = 'spec/fixtures'
  config.hook_into = 'spec/fixtures'
end
