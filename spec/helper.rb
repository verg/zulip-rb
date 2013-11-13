def fixture(file)
  File.new(fixture_path + '/' + file)
end

def fixture_path
  File.expand_path("../fixtures", __FILE__)
end
