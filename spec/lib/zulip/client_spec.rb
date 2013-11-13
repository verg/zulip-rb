require_relative "../../../lib/zulip"

describe Zulip::Client do
  describe "configuration" do
    it "yields itself upon initialization for configuration" do

      client = Zulip::Client.new do |config|
        config.bot_email_address = "bot@example.com"
        config.bot_api_key = "apikey"
      end

      expect(client.bot_email_address).to eq "bot@example.com"
      expect(client.bot_api_key).to eq "apikey"
    end
  end
end
