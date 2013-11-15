require 'json'

def parsed_json_fixture(file)
  JSON.parse(fixture(file))
end

def fixture(file)
  File.new(fixture_path + '/' + file).read
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end
